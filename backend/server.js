import http from 'node:http';
import OpenAI from 'openai';

const port = Number(process.env.PORT || 8787);
const model = process.env.AI_MODEL || process.env.OPENAI_MODEL;
const allowedOrigin = process.env.CORS_ORIGIN || '*';
let client;
const requestsByIp = new Map();
const maxContextChars = 28_000;
const systemPrompt = `Você é a NutriIA, assistente de alimentação saudável do NutriReceitas.
Converse em português do Brasil com naturalidade, acolhimento e clareza. Você é especializada em
alimentação equilibrada, receitas, culinária prática, planejamento de refeições, listas de compras,
substituições, leitura geral de rótulos e educação alimentar.

COMPORTAMENTO:
- Mantenha o contexto da conversa e use informações já ditas, como preferências, aversões, tempo,
  orçamento, ingredientes disponíveis e número de porções. Não peça novamente algo que já foi informado.
- Faça perguntas complementares apenas quando forem realmente úteis; quando houver informação suficiente,
  responda diretamente.
- Adapte a profundidade à pergunta: seja breve em dúvidas simples e estruturada em planejamentos complexos.
- Quando sugerir receita do catálogo, use somente os dados fornecidos e não invente que uma receita existe.
  Você pode criar uma receita nova, mas deixe claro que é uma sugestão criada pela NutriIA.
- Para receitas, organize título, tempo, porções, ingredientes com quantidades e preparo em passos.
- Para comparações e educação alimentar, explique de modo prático, sem transformar toda pergunta em receita.
- Não revele raciocínio interno privado; explique apenas os critérios úteis da recomendação.
- Evite respostas repetitivas e não encerre sempre com “como posso ajudar?”.

SEGURANÇA:
- Não diagnostique, prescreva medicamentos, dietas clínicas ou prometa emagrecimento/resultados de saúde.
- Não invente calorias ou valores nutricionais exatos. Se não houver dados confiáveis, diga que é uma estimativa
  ou que a pessoa deve consultar um nutricionista.
- Em alergia grave, gestação, transtorno alimentar, doença ou outra condição individual, seja cuidadosa e
  recomende orientação de profissional habilitado. Ofereça apenas informação geral e segura.

CATÁLOGO:
O catálogo abaixo contém receitas reais do aplicativo. Use-o para recomendar opções existentes e respeite
categoria, refeição e ingredientes. Não cite o catálogo inteiro sem necessidade.`;

function getClient() {
  if (!client) client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  return client;
}

function json(response, status, body) {
  response.writeHead(status, {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': allowedOrigin,
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
  });
  response.end(JSON.stringify(body));
}

function readBody(request) {
  return new Promise((resolve, reject) => {
    let data = '';
    request.on('data', chunk => {
      data += chunk;
      if (data.length > 200_000) reject(new Error('payload too large'));
    });
    request.on('end', () => {
      try {
        resolve(JSON.parse(data || '{}'));
      } catch (_) {
        reject(new Error('invalid json'));
      }
    });
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
    if (!messages.length || !messages.every(item => ['user', 'assistant'].includes(item.role) && typeof item.content === 'string')) {
      return json(response, 400, { error: 'Conversa inválida.' });
    }
    const preferences = typeof body.preferences === 'string' && body.preferences ? body.preferences : 'Nenhuma preferência cadastrada.';
    const recipeCatalog = typeof body.recipeCatalog === 'string' ? body.recipeCatalog.slice(0, 16_000) : 'Catálogo não disponível.';
    const context = [];
    let contextChars = 0;
    for (let index = messages.length - 1; index >= 0 && context.length < 24; index -= 1) {
      const item = messages[index];
      const size = item.content.length;
      if (context.length > 0 && contextChars + size > maxContextChars) break;
      context.unshift(item);
      contextChars += size;
    }

    const completion = await getClient().chat.completions.create({
      model,
      temperature: 0.7,
      messages: [
        {
          role: 'system',
          content: `${systemPrompt}\nPreferências alimentares cadastradas: ${preferences}\n\nReceitas do catálogo:\n${recipeCatalog}`,
        },
        ...context,
      ],
    });
    const message = completion.choices?.[0]?.message?.content;
    if (typeof message !== 'string' || !message.trim()) return json(response, 502, { error: 'A IA não retornou uma resposta válida.' });
    return json(response, 200, { message: message.trim() });
  } catch (error) {
    if (error.message === 'invalid json') return json(response, 400, { error: 'A mensagem enviada não está em um formato válido.' });
    console.error(error);
    return json(response, 500, { error: 'Não foi possível conectar à NutriIA agora. Tente novamente.' });
  }
});

server.listen(port, () => console.log(`NutriIA backend disponível em http://localhost:${port}`));
