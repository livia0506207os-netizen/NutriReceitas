# NutriReceitas

Aplicativo academico de receitas desenvolvido com Flutter e Dart, inspirado no prototipo do Figma do projeto.

## Funcionalidades

- Cadastro, login e logout com persistencia local.
- Perfil com edicao de nome/e-mail e foto escolhida pelo seletor do dispositivo ou navegador.
- Preferencias alimentares e configuracoes de notificacoes salvas localmente.
- Home com categorias, busca em tempo real e detalhes das receitas.
- Filtros por categoria, tempo e dificuldade padronizada: Facil, Media e Dificil.
- Favoritos persistentes com `shared_preferences`.
- NutriIA com histórico de conversa, preferências alimentares e integração via backend seguro.
- NutriIA com contexto limitado por tamanho, catálogo real de receitas e cópia de respostas.
- Layout responsivo para mobile e Flutter Web.

## Tecnologias

- Flutter e Dart
- `shared_preferences` para persistencia local
- `image_picker` para selecionar fotos no mobile e Web
- Google Fonts com Jost

## Executar localmente

```bash
flutter pub get
flutter run
```

Para executar no navegador:

```bash
flutter run -d chrome
```

Para gerar o build de producao do GitHub Pages:

```bash
flutter build web --release --base-href /NutriReceitas/
```

## Deploy

O workflow `.github/workflows/deploy.yml` executa o build e publica `build/web` no GitHub Pages quando recebe um push na branch `desenvolvimento` ou quando e iniciado manualmente. No repositorio do GitHub, ative Pages com a origem **GitHub Actions**.

Depois do primeiro workflow concluido, o endereco esperado e:

`https://livia0506207os-netizen.github.io/NutriReceitas/`

## Estrutura

```text
lib/
  data/                 dados das receitas
  models/               modelo Recipe
  screens/              telas e fluxos de navegacao
  services/             controllers persistentes
  theme/                cores e estilos
  widgets/              componentes reutilizaveis
test/                   testes de receitas, busca e autenticacao inicial
```

## Configurar a NutriIA

O app não contém nenhuma chave de API. No backend, configure `OPENAI_API_KEY` e `AI_MODEL`
com variáveis de ambiente e execute:

```bash
cd backend
npm install
node server.js
```

Em outro terminal:

```bash
flutter run --dart-define=NUTRIA_API_URL=http://localhost:8787/chat
```

Em celular físico, use o IP da máquina no lugar de `localhost`. Em produção, publique o backend
com HTTPS. Nunca coloque a chave da OpenAI no Flutter ou no GitHub.

## GitHub Pages e Render

O workflow `.github/workflows/deploy.yml` publica a branch `desenvolvimento` no endereço
`https://livia0506207os-netizen.github.io/NutriReceitas/`. No GitHub, configure Pages com a origem
**GitHub Actions** e crie a variável de repositório `NUTRIA_API_URL` com a URL pública do backend,
por exemplo `https://nutria-backend.onrender.com/chat`. Sem essa variável, o app continua abrindo,
mas informa que a NutriIA não foi configurada.

Para o Render, crie um novo Blueprint apontando para este repositório e aceite o `render.yaml`.
Depois preencha `OPENAI_API_KEY` e `AI_MODEL` nos Environment Variables do serviço. A chave fica
somente no Render; o Flutter recebe apenas a URL pública por `NUTRIA_API_URL`.

O backend mantém até 24 mensagens recentes dentro de um limite aproximado de 28 mil caracteres e
recebe um resumo do catálogo real de receitas do aplicativo. O modelo continua configurável por
`AI_MODEL` (ou `OPENAI_MODEL` por compatibilidade); o projeto não presume nem fixa um modelo que
possa não estar disponível na conta.
