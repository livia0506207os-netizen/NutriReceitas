# NutriIA no Cloudflare Workers

Este Worker substitui o backend Flask/Render quando você quiser usar a opção gratuita do Cloudflare.
Ele mantém `GEMINI_API_KEY` fora do navegador e do GitHub.

## Publicar pelo painel Cloudflare

1. Crie uma conta em <https://dash.cloudflare.com/>.
2. Abra **Workers & Pages** e clique em **Create application**.
3. Escolha **Create Worker** e informe o nome `nutrireceitas-nutria`.
4. Depois de criar, abra **Edit code**.
5. Substitua o código pelo conteúdo de `src/index.js` deste diretório e clique em **Deploy**.
6. Em **Settings > Variables and Secrets**, adicione:

   - `GEMINI_API_KEY` como **Secret**;
   - `GEMINI_MODEL` como variável de texto, usando o identificador exato do modelo disponível na sua conta;
   - `CORS_ORIGIN` como variável de texto com o valor `https://livia0506207os-netizen.github.io`.

7. Clique em **Save and deploy**.
8. Teste `https://SEU-WORKER.workers.dev/health`. O retorno esperado é `ok: true` e `geminiConfigured: true`.

## Publicar pela CLI (opcional)

Com o Node.js instalado:

```bash
cd cloudflare-worker
npx wrangler login
npx wrangler secret put GEMINI_API_KEY
npx wrangler deploy
```

O comando `secret put` solicitará os valores no terminal sem gravá-los no repositório.

Depois do deploy, a URL para o Flutter será:

```text
https://SEU-WORKER.workers.dev/api/chat
```

Não coloque a chave Gemini no Flutter, no `web/index.html` ou em variáveis do GitHub Pages.
