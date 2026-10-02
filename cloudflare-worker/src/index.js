const SYSTEM_PROMPT = `Você é a NutriIA, assistente de alimentação saudável do NutriReceitas.
Converse em português do Brasil com naturalidade, acolhimento e clareza. Você é especializada em
alimentação equilibrada, receitas, culinária prática, planejamento de refeições, listas de compras,
substituições, leitura geral de rótulos e educação alimentar.

Mantenha o contexto da conversa e use preferências, aversões, tempo, orçamento, ingredientes disponíveis
e número de porções já informados. Para receitas, organize título, tempo, porções, ingredientes com
quantidades e preparo em passos. Não invente receitas do catálogo. Não diagnostique, prescreva medicamentos,
dietas clínicas ou prometa resultados de saúde. Em alergia grave, gestação, transtorno alimentar, doença
ou outra condição individual, recomende orientação de profissional habilitado.`;

const MAX_CONTEXT_CHARS = 28000;
const MAX_MESSAGES = 24;
const MAX_BODY_CHARS = 52000;
const WINDOW_MS = 60000;
const MAX_REQUESTS_PER_IP = 20;
const requestLog = new Map();

function json(data, status = 200, origin) {
  const headers = {
    'content-type': 'application/json; charset=utf-8',
    'cache-control': 'no-store',
  };
  if (origin) {
    headers['access-control-allow-origin'] = origin;
    headers['access-control-allow-methods'] = 'POST, GET, OPTIONS';
    headers['access-control-allow-headers'] = 'Content-Type';
    headers['vary'] = 'Origin';
  }
  return new Response(JSON.stringify(data), {
    status,
    headers,
  });
}

function recentContext(messages) {
  const selected = [];
  let total = 0;
  for (let i = messages.length - 1; i >= 0; i -= 1) {
    const message = messages[i];
    if (selected.length > 0 && (total + message.content.length > MAX_CONTEXT_CHARS || selected.length >= MAX_MESSAGES)) break;
    selected.unshift(message);
    total += message.content.length;
  }
  return selected;
}

function limited(ip) {
  const now = Date.now();
  const previous = (requestLog.get(ip) || []).filter((time) => now - time < WINDOW_MS);
  if (previous.length >= MAX_REQUESTS_PER_IP) return true;
  previous.push(now);
  requestLog.set(ip, previous);
  return false;
}

function validMessages(messages) {
  return Array.isArray(messages) && messages.length > 0 && messages.length <= MAX_MESSAGES && messages.every((message) => (
    message && (message.role === 'user' || message.role === 'assistant')
    && typeof message.content === 'string'
    && message.content.trim()
    && message.content.length <= 6000
  ));
}

async function chat(request, env, origin) {
  if (!env.GEMINI_API_KEY || !env.GEMINI_MODEL) {
    return json({ error: 'A NutriIA ainda não foi configurada no backend.' }, 503, origin);
  }

  const ip = request.headers.get('CF-Connecting-IP') || 'unknown';
  if (limited(ip)) {
    return json({ error: 'Limite temporário de mensagens atingido. Tente novamente em instantes.' }, 429, origin);
  }

  let body;
  try {
    const rawBody = await request.text();
    if (rawBody.length > MAX_BODY_CHARS) {
      return json({ error: 'A conversa enviada é grande demais.' }, 413, origin);
    }
    body = JSON.parse(rawBody);
  } catch {
    return json({ error: 'A mensagem enviada não está em um formato válido.' }, 400, origin);
  }

  if (!validMessages(body.messages)) return json({ error: 'Conversa inválida.' }, 400, origin);

  const preferences = String(body.preferences || 'Nenhuma preferência cadastrada.').slice(0, 4000);
  const catalog = String(body.recipeCatalog || 'Catálogo não disponível.').slice(0, 16000);
  const messagesChars = body.messages.reduce((total, message) => total + message.content.length, 0);
  if (messagesChars + preferences.length + catalog.length > MAX_CONTEXT_CHARS) {
    return json({ error: 'O contexto da conversa é grande demais.' }, 413, origin);
  }
  const contents = recentContext(body.messages).map((message) => ({
    role: message.role === 'assistant' ? 'model' : 'user',
    parts: [{ text: message.content }],
  }));
  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(env.GEMINI_MODEL)}:generateContent`;
  const payload = {
    systemInstruction: { parts: [{ text: `${SYSTEM_PROMPT}\n\nPreferências: ${preferences}\n\nCatálogo:\n${catalog}` }] },
    contents,
    generationConfig: { temperature: 0.7, maxOutputTokens: 2048 },
  };

  let response;
  try {
    response = await fetch(endpoint, {
      method: 'POST',
      headers: { 'content-type': 'application/json', 'x-goog-api-key': env.GEMINI_API_KEY },
      body: JSON.stringify(payload),
    });
  } catch {
    return json({ error: 'Não foi possível conectar à Gemini agora. Tente novamente.' }, 502, origin);
  }

  if (!response.ok) {
    if (response.status === 429) return json({ error: 'A Gemini atingiu o limite temporário. Tente novamente em instantes.' }, 429, origin);
    if (response.status === 400) return json({ error: 'O Gemini rejeitou o formato da solicitação.' }, 502, origin);
    if (response.status === 401 || response.status === 403) return json({ error: 'A credencial do Gemini foi rejeitada.' }, 502, origin);
    if (response.status === 404) return json({ error: 'O modelo Gemini configurado não foi encontrado.' }, 502, origin);
    return json({ error: 'A Gemini não conseguiu processar a mensagem. Verifique o modelo e tente novamente.' }, 502, origin);
  }

  let data;
  try {
    data = await response.json();
    const answer = data.candidates?.[0]?.content?.parts?.map((part) => part.text || '').join('').trim();
    if (!answer) throw new Error('empty response');
    return json({ message: answer }, 200, origin);
  } catch {
    return json({ error: 'A Gemini retornou uma resposta inválida.' }, 502, origin);
  }
}

export default {
  async fetch(request, env) {
    const configuredOrigin = env.CORS_ORIGIN || 'https://livia0506207os-netizen.github.io';
    const requestOrigin = request.headers.get('Origin');
    const origin = requestOrigin === configuredOrigin ? configuredOrigin : undefined;
    const url = new URL(request.url);

    if (url.pathname !== '/health' && url.pathname !== '/api/chat' && url.pathname !== '/chat') {
      return json({ error: 'Rota não encontrada.' }, 404, origin);
    }
    if (request.method === 'OPTIONS') {
      if (!origin) return json({ error: 'Origem não permitida.' }, 403);
      return json({}, 204, origin);
    }
    if (url.pathname === '/health' && request.method === 'GET') {
      return json({ ok: true, geminiConfigured: Boolean(env.GEMINI_API_KEY && env.GEMINI_MODEL) }, 200, origin);
    }
    if ((url.pathname === '/api/chat' || url.pathname === '/chat') && request.method === 'POST') {
      try {
        return await chat(request, env, origin);
      } catch {
        return json({ error: 'Não foi possível processar a solicitação agora.' }, 500, origin);
      }
    }
    return json({ error: 'Método não permitido.' }, 405, origin);
  },
};
