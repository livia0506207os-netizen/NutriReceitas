import os
import time
from collections import defaultdict, deque
from urllib.parse import quote

import requests
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 200 * 1024
CORS(app, resources={r'/api/*': {'origins': os.getenv('CORS_ORIGIN', '*')}})

WINDOW_SECONDS = 60
MAX_REQUESTS_PER_IP = 20
MAX_CONTEXT_CHARS = 28_000
MAX_MESSAGES = 24
requests_by_ip = defaultdict(deque)

SYSTEM_PROMPT = '''Você é a NutriIA, assistente de alimentação saudável do NutriReceitas.
Converse em português do Brasil com naturalidade, acolhimento e clareza. Você é especializada em
alimentação equilibrada, receitas, culinária prática, planejamento de refeições, listas de compras,
substituições, leitura geral de rótulos e educação alimentar.

COMPORTAMENTO:
- Mantenha o contexto da conversa e use informações já ditas, como preferências, aversões, tempo,
  orçamento, ingredientes disponíveis e número de porções. Não peça novamente algo já informado.
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
categoria, refeição e ingredientes. Não cite o catálogo inteiro sem necessidade.'''


def json_error(message, status):
    return jsonify({'error': message}), status


def has_capacity(client_ip):
    now = time.monotonic()
    timestamps = requests_by_ip[client_ip]
    while timestamps and now - timestamps[0] >= WINDOW_SECONDS:
        timestamps.popleft()
    if len(timestamps) >= MAX_REQUESTS_PER_IP:
        return False
    timestamps.append(now)
    return True


def recent_context(messages):
    selected = []
    total_chars = 0
    for message in reversed(messages):
        content = message['content']
        if selected and (total_chars + len(content) > MAX_CONTEXT_CHARS or len(selected) >= MAX_MESSAGES):
            break
        selected.insert(0, message)
        total_chars += len(content)
    return selected


def gemini_contents(messages):
    return [
        {
            'role': 'model' if message['role'] == 'assistant' else 'user',
            'parts': [{'text': message['content']}],
        }
        for message in messages
    ]


@app.get('/health')
def health():
    configured = bool(os.getenv('GEMINI_API_KEY') and os.getenv('GEMINI_MODEL'))
    return jsonify({'ok': True, 'geminiConfigured': configured})


@app.post('/api/chat')
@app.post('/chat')
def chat():
    api_key = os.getenv('GEMINI_API_KEY')
    model = os.getenv('GEMINI_MODEL')
    if not api_key or not model:
        return json_error('A NutriIA ainda não foi configurada no backend.', 503)

    client_ip = request.headers.get('X-Forwarded-For', request.remote_addr or 'unknown').split(',')[0].strip()
    if not has_capacity(client_ip):
        return json_error('Limite temporário de mensagens atingido. Tente novamente em instantes.', 429)

    try:
        body = request.get_json(silent=False) or {}
    except Exception:
        return json_error('A mensagem enviada não está em um formato válido.', 400)

    messages = body.get('messages')
    if not isinstance(messages, list) or not messages:
        return json_error('Conversa inválida.', 400)
    if any(
        not isinstance(message, dict)
        or message.get('role') not in ('user', 'assistant')
        or not isinstance(message.get('content'), str)
        or not message['content'].strip()
        for message in messages
    ):
        return json_error('Conversa inválida.', 400)

    preferences = body.get('preferences') or 'Nenhuma preferência cadastrada.'
    catalog = str(body.get('recipeCatalog') or 'Catálogo não disponível.')[:16_000]
    context = recent_context(messages)
    prompt = f'{SYSTEM_PROMPT}\n\nPreferências alimentares cadastradas: {preferences}\n\nReceitas do catálogo:\n{catalog}'
    endpoint = f'https://generativelanguage.googleapis.com/v1beta/models/{quote(model, safe="")}:generateContent'
    payload = {
        'system_instruction': {'parts': [{'text': prompt}]},
        'contents': gemini_contents(context),
        'generationConfig': {'temperature': 0.7, 'maxOutputTokens': 2048},
    }

    try:
        response = requests.post(
            endpoint,
            headers={'x-goog-api-key': api_key, 'Content-Type': 'application/json'},
            json=payload,
            timeout=45,
        )
    except requests.Timeout:
        return json_error('A NutriIA demorou mais que o esperado para responder. Tente novamente.', 504)
    except requests.RequestException:
        return json_error('Não foi possível conectar à Gemini agora. Tente novamente.', 502)

    if response.status_code >= 400:
        app.logger.warning('Gemini returned %s: %s', response.status_code, response.text[:500])
        if response.status_code == 429:
            return json_error('A Gemini atingiu o limite temporário. Tente novamente em instantes.', 429)
        return json_error('A Gemini não conseguiu processar a mensagem. Verifique o modelo e tente novamente.', 502)

    try:
        data = response.json()
        parts = data['candidates'][0]['content']['parts']
        answer = ''.join(part.get('text', '') for part in parts).strip()
    except (ValueError, KeyError, IndexError, TypeError):
        return json_error('A Gemini retornou uma resposta inválida.', 502)
    if not answer:
        return json_error('A Gemini não retornou uma resposta válida.', 502)
    return jsonify({'message': answer})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', '8787')))
