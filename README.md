# NutriReceitas

Aplicativo academico de receitas desenvolvido com Flutter e Dart, inspirado no prototipo do Figma do projeto.

## Funcionalidades

- Cadastro, login e logout com persistencia local.
- Perfil com edicao de nome/e-mail e foto escolhida pelo seletor do dispositivo ou navegador.
- Preferencias alimentares e configuracoes de notificacoes salvas localmente.
- Home com categorias, busca em tempo real e detalhes das receitas.
- Filtros por categoria, tempo e dificuldade padronizada: Facil, Media e Dificil.
- Favoritos persistentes com `shared_preferences`.
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
