import '../models/recipe.dart';

const recipes = <Recipe>[
  Recipe(
    id: 1,
    name: 'Bolo de banana',
    category: 'Sobremesas',
    mealType: 'Café da manhã',
    imageUrl:
        'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=900&q=85',
    description:
        'Um bolo simples de banana, macio e perfeito para acompanhar o café.',
    ingredients: [
      '2 bananas maduras',
      '2 ovos',
      '1 xícara de aveia',
      '1 colher de mel'
    ],
    steps: [
      'Amasse as bananas.',
      'Misture os ingredientes.',
      'Coloque em uma forma.',
      'Leve ao forno por 30 minutos.'
    ],
    minutes: 40,
    servings: 8,
    difficulty: 'Média',
    calories: 700,
  ),
  Recipe(
    id: 2,
    name: 'Frango grelhado com legumes',
    category: 'Carnes',
    mealType: 'Almoço',
    imageUrl:
        'https://images.unsplash.com/photo-1532550907401-a500c9a57435?auto=format&fit=crop&w=900&q=85',
    description: 'Frango grelhado acompanhado de legumes frescos e temperados.',
    ingredients: [
      '1 filé de frango',
      'Brócolis',
      'Abobrinha',
      'Azeite e temperos'
    ],
    steps: [
      'Tempere o frango.',
      'Grelhe o frango.',
      'Refogue os legumes no azeite.',
      'Sirva quente.'
    ],
    minutes: 25,
    servings: 1,
    difficulty: 'Média',
    calories: 330,
  ),
  Recipe(
    id: 3,
    name: 'Omelete de espinafre',
    category: 'Outras',
    mealType: 'Café da manhã',
    imageUrl:
        'https://images.unsplash.com/photo-1510693206972-df098062cb71?auto=format&fit=crop&w=900&q=85',
    description: 'Omelete rápido, leve e cheio de sabor.',
    ingredients: ['3 ovos', 'Punhado de espinafre', 'Sal e pimenta'],
    steps: [
      'Bata os ovos.',
      'Misture o espinafre picado.',
      'Frite na frigideira.'
    ],
    minutes: 10,
    servings: 1,
    difficulty: 'Fácil',
    calories: 220,
  ),
  Recipe(
    id: 4,
    name: 'Salada de grão-de-bico',
    category: 'Saladas',
    mealType: 'Almoço',
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=85',
    description: 'Salada refrescante de grão-de-bico, tomate e pepino.',
    ingredients: [
      '1 xícara de grão-de-bico cozido',
      'Tomate',
      'Pepino',
      'Azeite'
    ],
    steps: [
      'Pique os vegetais.',
      'Misture todos os ingredientes.',
      'Tempere com azeite e sal.'
    ],
    minutes: 15,
    servings: 2,
    difficulty: 'Fácil',
    calories: 420,
  ),
  Recipe(
    id: 5,
    name: 'Panqueca de banana',
    category: 'Massas',
    mealType: 'Café da manhã',
    imageUrl:
        'https://images.unsplash.com/photo-1528207776546-365bb710ee93?auto=format&fit=crop&w=900&q=85',
    description: 'Panqueca prática feita com banana e aveia.',
    ingredients: [
      '1 banana',
      '2 ovos',
      '3 colheres de aveia',
      'Canela a gosto'
    ],
    steps: [
      'Bata tudo no liquidificador.',
      'Aqueça uma frigideira.',
      'Frite as panquecas.'
    ],
    minutes: 15,
    servings: 2,
    difficulty: 'Fácil',
    calories: 330,
  ),
  Recipe(
    id: 6,
    name: 'Vitamina de frutas vermelhas',
    category: 'Bebidas',
    mealType: 'Café da manhã',
    imageUrl:
        'https://images.unsplash.com/photo-1553530666-ba11a7da3888?auto=format&fit=crop&w=900&q=85',
    description: 'Vitamina cremosa de frutas vermelhas para começar o dia.',
    ingredients: ['1 copo de leite', 'Morango', 'Amora', '1 colher de aveia'],
    steps: [
      'Coloque todos os ingredientes no liquidificador.',
      'Bata até ficar homogêneo.',
      'Sirva gelado.'
    ],
    minutes: 5,
    servings: 1,
    difficulty: 'Fácil',
    calories: 240,
  ),
  Recipe(
    id: 7,
    name: 'Wrap de grão-de-bico',
    category: 'Lanches',
    mealType: 'Lanche',
    imageUrl:
        'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=85',
    description: 'Wrap integral com grão-de-bico e vegetais crocantes.',
    ingredients: [
      '1 tortilla integral',
      'Grão-de-bico amassado',
      'Alface',
      'Cenoura ralada'
    ],
    steps: ['Prepare o recheio.', 'Monte o wrap.', 'Enrole bem e sirva.'],
    minutes: 10,
    servings: 1,
    difficulty: 'Fácil',
    calories: 270,
  ),
  Recipe(
    id: 8,
    name: 'Curry de legumes',
    category: 'Outras',
    mealType: 'Jantar',
    imageUrl:
        'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7?auto=format&fit=crop&w=900&q=85',
    description: 'Curry cremoso com legumes e leite de coco.',
    ingredients: ['Leite de coco', 'Batata-doce', 'Couve-flor', 'Curry em pó'],
    steps: [
      'Refogue os legumes.',
      'Adicione leite de coco e curry.',
      'Cozinhe por 20 minutos.'
    ],
    minutes: 30,
    servings: 3,
    difficulty: 'Média',
    calories: 650,
  ),
  Recipe(
    id: 9,
    name: 'Hambúrguer de lentilha',
    category: 'Lanches',
    mealType: 'Jantar',
    imageUrl:
        'https://images.unsplash.com/photo-1520072959219-c595dc870360?auto=format&fit=crop&w=900&q=85',
    description: 'Hambúrguer vegetal rico em sabor e fácil de preparar.',
    ingredients: [
      '1 xícara de lentilha cozida',
      'Farinha de aveia',
      'Cebola',
      'Temperos'
    ],
    steps: [
      'Amasse a lentilha.',
      'Misture os demais ingredientes.',
      'Modele e frite os hambúrgueres.'
    ],
    minutes: 20,
    servings: 3,
    difficulty: 'Média',
    calories: 350,
  ),
  Recipe(
    id: 10,
    name: 'Salada caprese fit',
    category: 'Saladas',
    mealType: 'Almoço',
    imageUrl:
        'https://images.unsplash.com/photo-1608897013039-887f21d8c804?auto=format&fit=crop&w=900&q=85',
    description: 'Uma versão leve e fresca da clássica salada caprese.',
    ingredients: ['Tomate', 'Mussarela de búfala', 'Manjericão', 'Azeite'],
    steps: [
      'Fatie o tomate e a mussarela.',
      'Intercale os ingredientes.',
      'Finalize com manjericão e azeite.'
    ],
    minutes: 10,
    servings: 2,
    difficulty: 'Fácil',
    calories: 420,
  ),
  Recipe(
    id: 11,
    name: 'Salada de quinoa',
    category: 'Saladas',
    mealType: 'Almoço',
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=900&q=85',
    description: 'Quinoa com vegetais frescos e tempero cítrico.',
    ingredients: [
      '1 xícara de quinoa cozida',
      'Pepino',
      'Tomate-cereja',
      'Limão'
    ],
    steps: [
      'Cozinhe a quinoa.',
      'Misture com os vegetais.',
      'Tempere com limão e azeite.'
    ],
    minutes: 20,
    servings: 2,
    difficulty: 'Fácil',
    calories: 310,
  ),
  Recipe(
    id: 12,
    name: 'Salada verde com frango',
    category: 'Saladas',
    mealType: 'Almoço',
    imageUrl:
        'https://images.unsplash.com/photo-1546793665-c74683f339c1?auto=format&fit=crop&w=900&q=85',
    description: 'Folhas verdes com frango desfiado e tomate.',
    ingredients: [
      'Folhas verdes',
      'Frango desfiado',
      'Tomate-cereja',
      'Azeite'
    ],
    steps: [
      'Prepare as folhas.',
      'Adicione o frango e tomate.',
      'Tempere e sirva.'
    ],
    minutes: 15,
    servings: 2,
    difficulty: 'Fácil',
    calories: 300,
  ),
  Recipe(
    id: 13,
    name: 'Bolinho de aveia e cacau',
    category: 'Sobremesas',
    mealType: 'Lanche',
    imageUrl:
        'https://images.unsplash.com/photo-1519869325930-281384150729?auto=format&fit=crop&w=900&q=85',
    description: 'Docinho simples de aveia, banana e cacau.',
    ingredients: ['Aveia', 'Cacau em pó', 'Banana amassada', 'Mel'],
    steps: [
      'Misture tudo.',
      'Modele bolinhas.',
      'Leve à geladeira por 20 minutos.'
    ],
    minutes: 20,
    servings: 10,
    difficulty: 'Fácil',
    calories: 330,
  ),
  Recipe(
    id: 14,
    name: 'Iogurte com granola',
    category: 'Outras',
    mealType: 'Café da manhã',
    imageUrl:
        'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=85',
    description: 'Café da manhã rápido com iogurte, frutas e granola.',
    ingredients: ['Iogurte natural', 'Granola', 'Mel', 'Frutas picadas'],
    steps: ['Monte em camadas.', 'Adicione as frutas.', 'Finalize com mel.'],
    minutes: 5,
    servings: 1,
    difficulty: 'Fácil',
    calories: 310,
  ),
  Recipe(
    id: 15,
    name: 'Mousse de chocolate fit',
    category: 'Sobremesas',
    mealType: 'Lanche',
    imageUrl:
        'https://images.unsplash.com/photo-1575377427642-087cf684f29d?auto=format&fit=crop&w=900&q=85',
    description: 'Mousse cremoso de chocolate com ingredientes simples.',
    ingredients: ['Abacate', 'Cacau em pó', 'Mel', 'Leite vegetal'],
    steps: [
      'Bata todos os ingredientes.',
      'Transfira para potes.',
      'Leve à geladeira.'
    ],
    minutes: 10,
    servings: 2,
    difficulty: 'Fácil',
    calories: 370,
  ),
];
