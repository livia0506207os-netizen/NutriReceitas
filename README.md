# NutriReceitas 🍃

Aplicativo acadêmico de Desenvolvimento Mobile feito com **Flutter + Dart**, inspirado no protótipo do Figma do projeto.

## Funcionalidades
- Home com destaques e categorias
- Busca por nome
- Filtros por categoria
- Filtros rápidos por tempo, calorias e dificuldade
- Detalhes completos da receita
- Favoritar/desfavoritar
- Persistência dos favoritos com `shared_preferences`
- Navegação inferior: Início, Buscar, Favoritos e Perfil
- Layout responsivo para diferentes tamanhos de tela

## Executar
```bash
flutter pub get
flutter run
```

## Estrutura
```text
lib/
├── main.dart
├── data/
│   └── mock_data.dart
├── models/
│   └── recipe.dart
├── screens/
│   ├── app_shell.dart
│   ├── home_screen.dart
│   ├── categories_screen.dart
│   ├── search_screen.dart
│   ├── favorites_screen.dart
│   ├── recipe_detail_screen.dart
│   └── profile_screen.dart
├── services/
│   └── favorites_controller.dart
├── theme/
│   ├── app_colors.dart
│   └── app_text_styles.dart
└── widgets/
    ├── bottom_nav.dart
    ├── category_card.dart
    └── recipe_card.dart
```

## Git
Sugestão de branches:
- `main`
- `pessoa1-home`
- `pessoa2-ui`
- `pessoa3-busca`
- `pessoa4-detalhes`
- `pessoa5-favoritos`
- `pessoa6-testes`

Exemplos de commits:
- `feat: cria tela home`
- `feat: adiciona busca por nome`
- `feat: implementa favoritos persistentes`
- `fix: corrige navegação inferior`
- `test: adiciona testes de receita`

## Observação
As imagens das receitas usam URLs públicas do Unsplash para manter o repositório leve. Para uma versão final, vocês podem trocar pelas imagens exportadas do Figma ou por assets locais.
