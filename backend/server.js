import http from 'node:http';
import OpenAI from 'openai';

const port = Number(process.env.PORT || 8787);
const model = process.env.OPENAI_MODEL;
const allowedOrigin = process.env.CORS_ORIGIN || '*';
const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const requestsByIp = new Map();
const systemPrompt = `Você é a NutriIA, assistente culinária do aplicativo NutriReceitas.
Responda em português do Brasil, com tom acolhedor e prático. Ajude com receitas, preparo,
substituições, aproveitamento de ingredientes e técnicas culinárias. Considere as preferências
do usuário quando informadas. Não invente informações nutricionais; quando não houver dados,
deixe claro que são estimativas ou que é necessário consultar um profissional. Não dê diagnóstico
médico. Organize receitas com ingredientes, quantidades e passos claros.`;

function json(response, status, body) {
  response.writeHead(status, { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': allowedOrigin, 'Access-Control-Allow-Headers': 'Content-Type' });
  response.end(JSON.stringify(body));
}

function readBody(request) {
  return new Promise((resolve, reject) => {
    let data = '';
    request.on('data', chunk => { data += chunk; if (data.length > 200_000) reject(new Error('payload too large')); });
    request.on('end', () => resolve(JSON.parse(data || '{}')));
    request.on('error', reject);
  });
}

const server = http.createServer(async (request, response) => {
  if (request.method === 'OPTIONS') return json(response, 204, {});
  if (request.method === 'GET' && request.url === '/health') return json(response, 200, { ok: true });
  if (request.method !== 'POST' || request.url !== '/chat') return json(response, 404, { error: 'Rota não encontrada.' });
  if (!process.env.OPENAI_API_KEY || !model) return json(response, 503, { error: 'A IA ainda não foi configurada no backend.' });
  const ip = request.socket.remoteAddress || 'unknown';
  const now = Date.now();
  const recent = (requestsByIp.get(ip) || []).filter(timestamp => now - timestamp < 60_000);
  if (recent.length >= 20) return json(response, 429, { error: 'Limite temporário de mensagens atingido. Tente novamente em instantes.' });
  recent.push(now);
  requestsByIp.set(ip, recent);
  try {
    const body = await readBody(request);
    const messages = Array.isArray(body.messages) ? body.messages : [];
    if (!messages.length || !messages.every(item => ['user', 'assistant'].includes(item.role) && typeof item.content === 'string')) return json(response, 400, { error: 'Conversa inválida.' });
    const preferences = typeof body.preferences === 'string' && body.preferences ? body.preferences : 'Nenhuma preferência cadastrada.';
    const completion = await client.chat.completions.create({
      model, temperature: 0.7,
      messages: [{ role: 'system', content: `${systemPrompt}\nPreferências alimentares cadastradas: ${preferences}` }, ...messages.slice(-20)],
    });
    const message = completion.choices?.[0]?.message?.content;
    if (typeof message !== 'string' || !message.trim()) return json(response, 502, { error: 'A IA não retornou uma resposta válida.' });
    return json(response, 200, { message: message.trim() });
  } catch (error) {
    console.error(error);
    return json(response, 500, { error: 'Não foi possível conectar à NutriIA agora. Tente novamente.' });
  }
});
server.listen(port, () => console.log(`NutriIA backend disponível em http://localhost:${port}`));
