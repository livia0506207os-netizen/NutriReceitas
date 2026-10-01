import '../models/recipe.dart';

Recipe _recipe({
  required int id,
  required String name,
  required String category,
  required String mealType,
  required String imageUrl,
  required String description,
  required List<String> ingredients,
  required List<String> steps,
  required int minutes,
  required int servings,
  required String difficulty,
  required int calories,
}) =>
    Recipe(
      id: id,
      name: name,
      category: category,
      mealType: mealType,
      imageUrl: '$imageUrl?auto=format&fit=crop&w=900&q=85',
      description: description,
      ingredients: ingredients,
      steps: steps,
      minutes: minutes,
      servings: servings,
      difficulty: difficulty,
      calories: calories,
    );

final additionalRecipes = <Recipe>[
  _recipe(
      id: 16,
      name: 'Espaguete ao molho de tomate',
      category: 'Massas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1551892374-ecf8754cf8b0',
      description:
          'Espaguete clássico com molho de tomate caseiro e manjericão.',
      ingredients: [
        '250 g de espaguete',
        '4 tomates maduros',
        '1 cebola pequena',
        '2 dentes de alho',
        'Manjericão e azeite'
      ],
      steps: [
        'Cozinhe o espaguete em água com sal.',
        'Refogue cebola e alho no azeite.',
        'Junte os tomates picados e cozinhe até formar o molho.',
        'Misture a massa ao molho e finalize com manjericão.'
      ],
      minutes: 30,
      servings: 3,
      difficulty: 'Fácil',
      calories: 410),
  _recipe(
      id: 17,
      name: 'Penne ao pesto',
      category: 'Massas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601',
      description: 'Penne envolvido em pesto fresco de manjericão e castanhas.',
      ingredients: [
        '250 g de penne',
        '2 xícaras de manjericão',
        '1/3 de xícara de castanhas',
        '1/2 xícara de parmesão',
        'Azeite e sal'
      ],
      steps: [
        'Cozinhe o penne e reserve meia xícara da água.',
        'Bata manjericão, castanhas, parmesão e azeite.',
        'Misture o pesto à massa ainda quente.',
        'Ajuste a textura com a água reservada e sirva.'
      ],
      minutes: 25,
      servings: 3,
      difficulty: 'Fácil',
      calories: 460),
  _recipe(
      id: 18,
      name: 'Lasanha de berinjela',
      category: 'Massas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1574868235882-8c9f2b5b4f6c',
      description:
          'Lasanha leve de berinjela, molho de tomate e queijo gratinado.',
      ingredients: [
        '2 berinjelas',
        '500 ml de molho de tomate',
        '250 g de muçarela',
        '100 g de parmesão',
        'Orégano e azeite'
      ],
      steps: [
        'Fatie e grelhe as berinjelas.',
        'Monte camadas de berinjela, molho e muçarela.',
        'Finalize com parmesão e orégano.',
        'Asse a 200 °C por 30 minutos.'
      ],
      minutes: 50,
      servings: 6,
      difficulty: 'Média',
      calories: 360),
  _recipe(
      id: 19,
      name: 'Nhoque de batata',
      category: 'Massas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141',
      description: 'Nhoque macio de batata servido com molho de tomate.',
      ingredients: [
        '500 g de batata',
        '1 gema',
        '1 xícara de farinha',
        'Sal',
        '2 xícaras de molho de tomate'
      ],
      steps: [
        'Cozinhe as batatas e amasse ainda quentes.',
        'Misture gema, sal e farinha até formar uma massa macia.',
        'Corte os nhoques e cozinhe até subirem.',
        'Sirva com o molho aquecido.'
      ],
      minutes: 60,
      servings: 4,
      difficulty: 'Média',
      calories: 390),
  _recipe(
      id: 20,
      name: 'Macarrão cremoso de abóbora',
      category: 'Massas',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1608219992759-8d74ae41b3d3',
      description: 'Massa cremosa com purê de abóbora, alho e ervas.',
      ingredients: [
        '250 g de fusilli',
        '300 g de abóbora cabotiá',
        '1/2 cebola',
        '1/2 xícara de creme de leite',
        'Sálvia, sal e pimenta'
      ],
      steps: [
        'Asse a abóbora até ficar macia.',
        'Bata a polpa com creme de leite e temperos.',
        'Cozinhe a massa e reserve um pouco da água.',
        'Aqueça o molho, envolva a massa e sirva.'
      ],
      minutes: 40,
      servings: 3,
      difficulty: 'Média',
      calories: 430),
  _recipe(
      id: 21,
      name: 'Ravioli de ricota e espinafre',
      category: 'Massas',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141',
      description:
          'Ravioli recheado com ricota e espinafre em molho de manteiga.',
      ingredients: [
        '400 g de ravioli',
        '200 g de ricota',
        '1 xícara de espinafre',
        '2 colheres de manteiga',
        'Parmesão e noz-moscada'
      ],
      steps: [
        'Cozinhe o ravioli conforme a embalagem.',
        'Refogue o espinafre e misture à ricota.',
        'Derreta a manteiga com noz-moscada.',
        'Sirva a massa com o molho e parmesão.'
      ],
      minutes: 25,
      servings: 4,
      difficulty: 'Fácil',
      calories: 440),
  _recipe(
      id: 22,
      name: 'Talharim com cogumelos',
      category: 'Massas',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601',
      description: 'Talharim com cogumelos dourados, alho e ervas frescas.',
      ingredients: [
        '250 g de talharim',
        '250 g de cogumelos',
        '2 dentes de alho',
        '1/2 xícara de creme de leite',
        'Salsinha e azeite'
      ],
      steps: [
        'Cozinhe o talharim.',
        'Doure os cogumelos no azeite com alho.',
        'Adicione o creme e tempere.',
        'Misture a massa e finalize com salsinha.'
      ],
      minutes: 25,
      servings: 3,
      difficulty: 'Fácil',
      calories: 420),
  _recipe(
      id: 23,
      name: 'Canelone de ricota',
      category: 'Massas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1574868235882-8c9f2b5b4f6c',
      description:
          'Canelone recheado com ricota e espinafre, coberto com molho.',
      ingredients: [
        '8 massas de canelone',
        '300 g de ricota',
        '1 xícara de espinafre',
        '500 ml de molho de tomate',
        '100 g de muçarela'
      ],
      steps: [
        'Misture ricota, espinafre e temperos.',
        'Recheie os canelones.',
        'Cubra com molho e muçarela.',
        'Asse por 35 minutos a 190 °C.'
      ],
      minutes: 55,
      servings: 4,
      difficulty: 'Média',
      calories: 390),
  _recipe(
      id: 24,
      name: 'Bife acebolado',
      category: 'Carnes',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      description: 'Bife macio dourado com cebolas caramelizadas.',
      ingredients: [
        '4 bifes de contrafilé',
        '2 cebolas fatiadas',
        '2 dentes de alho',
        '1 colher de manteiga',
        'Sal e pimenta'
      ],
      steps: [
        'Tempere os bifes.',
        'Aqueça bem a frigideira e doure a carne dos dois lados.',
        'Reserve os bifes e refogue as cebolas na manteiga.',
        'Volte os bifes à frigideira e sirva.'
      ],
      minutes: 25,
      servings: 4,
      difficulty: 'Fácil',
      calories: 430),
  _recipe(
      id: 25,
      name: 'Almôndegas ao molho',
      category: 'Carnes',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1529042410759-befb1204b468',
      description: 'Almôndegas suculentas cozidas em molho de tomate.',
      ingredients: [
        '500 g de carne moída',
        '1 ovo',
        '1/2 xícara de farinha de rosca',
        '1 cebola picada',
        '500 ml de molho de tomate'
      ],
      steps: [
        'Misture carne, ovo, farinha e cebola.',
        'Modele as almôndegas.',
        'Doure em uma panela.',
        'Adicione o molho e cozinhe por 20 minutos.'
      ],
      minutes: 45,
      servings: 4,
      difficulty: 'Média',
      calories: 390),
  _recipe(
      id: 26,
      name: 'Carne de panela com legumes',
      category: 'Carnes',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      description: 'Carne cozida lentamente com cenoura e batata.',
      ingredients: [
        '800 g de acém em cubos',
        '2 batatas',
        '2 cenouras',
        '1 cebola',
        '500 ml de caldo de carne'
      ],
      steps: [
        'Sele a carne em uma panela quente.',
        'Refogue cebola e junte o caldo.',
        'Cozinhe tampado até amaciar.',
        'Adicione batatas e cenouras e finalize o cozimento.'
      ],
      minutes: 90,
      servings: 5,
      difficulty: 'Média',
      calories: 520),
  _recipe(
      id: 27,
      name: 'Picadinho de carne',
      category: 'Carnes',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      description: 'Cubos de carne com molho encorpado e ervas.',
      ingredients: [
        '500 g de alcatra em cubos',
        '1 tomate',
        '1 cebola',
        '1/2 xícara de caldo',
        'Cheiro-verde e azeite'
      ],
      steps: [
        'Doure a carne em pequenas porções.',
        'Refogue cebola e tomate.',
        'Junte a carne e o caldo.',
        'Cozinhe por 20 minutos e finalize com cheiro-verde.'
      ],
      minutes: 40,
      servings: 4,
      difficulty: 'Fácil',
      calories: 410),
  _recipe(
      id: 28,
      name: 'Kafta assada',
      category: 'Carnes',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1529193591184-b1d58069ecdd',
      description: 'Kafta temperada com hortelã, cebola e especiarias.',
      ingredients: [
        '500 g de carne moída',
        '1 cebola ralada',
        'Hortelã picada',
        '1 colher de cominho',
        'Sal e pimenta'
      ],
      steps: [
        'Misture todos os ingredientes.',
        'Modele em espetos ou cilindros.',
        'Disponha em assadeira untada.',
        'Asse a 220 °C por 20 minutos, virando na metade.'
      ],
      minutes: 35,
      servings: 4,
      difficulty: 'Fácil',
      calories: 360),
  _recipe(
      id: 29,
      name: 'Carne assada com ervas',
      category: 'Carnes',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      description: 'Peça de carne assada lentamente com alho e ervas.',
      ingredients: [
        '1 kg de maminha',
        '4 dentes de alho',
        'Alecrim e tomilho',
        '2 colheres de azeite',
        'Sal e pimenta'
      ],
      steps: [
        'Tempere a carne com alho, ervas e azeite.',
        'Sele todos os lados em frigideira.',
        'Asse a 200 °C até o ponto desejado.',
        'Descanse por 10 minutos antes de fatiar.'
      ],
      minutes: 70,
      servings: 6,
      difficulty: 'Média',
      calories: 480),
  _recipe(
      id: 30,
      name: 'Escondidinho de carne',
      category: 'Carnes',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7',
      description: 'Purê de mandioca com recheio de carne moída bem temperada.',
      ingredients: [
        '600 g de mandioca',
        '400 g de carne moída',
        '1 cebola',
        '100 g de muçarela',
        'Leite e manteiga'
      ],
      steps: [
        'Cozinhe e amasse a mandioca com leite e manteiga.',
        'Prepare a carne com cebola e tomate.',
        'Monte purê, carne e outra camada de purê.',
        'Cubra com queijo e gratine.'
      ],
      minutes: 60,
      servings: 6,
      difficulty: 'Média',
      calories: 470),
  _recipe(
      id: 31,
      name: 'Fricassê de frango',
      category: 'Carnes',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435',
      description: 'Frango cremoso com milho e cobertura gratinada.',
      ingredients: [
        '500 g de frango desfiado',
        '1 lata de milho',
        '200 g de creme de leite',
        '100 g de requeijão',
        '100 g de muçarela'
      ],
      steps: [
        'Bata milho, creme e requeijão.',
        'Misture ao frango e ajuste o sal.',
        'Transfira para um refratário.',
        'Cubra com queijo e gratine por 20 minutos.'
      ],
      minutes: 45,
      servings: 5,
      difficulty: 'Fácil',
      calories: 430),
  _recipe(
      id: 32,
      name: 'Salada mediterrânea',
      category: 'Saladas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999',
      description: 'Salada fresca com pepino, tomate, azeitona e queijo feta.',
      ingredients: [
        '2 tomates',
        '1 pepino',
        '1/2 cebola roxa',
        '100 g de queijo feta',
        'Azeitonas, limão e azeite'
      ],
      steps: [
        'Corte os vegetais em pedaços.',
        'Adicione queijo e azeitonas.',
        'Misture limão, azeite, sal e pimenta.',
        'Regue a salada e sirva fresca.'
      ],
      minutes: 15,
      servings: 3,
      difficulty: 'Fácil',
      calories: 240),
  _recipe(
      id: 33,
      name: 'Salada de macarrão',
      category: 'Saladas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601',
      description: 'Salada colorida de macarrão, legumes e molho de iogurte.',
      ingredients: [
        '250 g de macarrão',
        '1 cenoura',
        '1/2 xícara de milho',
        'Tomate-cereja',
        'Iogurte, limão e ervas'
      ],
      steps: [
        'Cozinhe o macarrão e deixe esfriar.',
        'Pique os legumes.',
        'Misture iogurte, limão e ervas.',
        'Combine tudo e leve à geladeira.'
      ],
      minutes: 25,
      servings: 4,
      difficulty: 'Fácil',
      calories: 320),
  _recipe(
      id: 34,
      name: 'Salada de lentilha',
      category: 'Saladas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      description: 'Lentilha com vegetais crocantes e molho de limão.',
      ingredients: [
        '1 xícara de lentilha cozida',
        '1 tomate',
        '1/2 pepino',
        'Salsinha',
        'Limão e azeite'
      ],
      steps: [
        'Cozinhe e escorra a lentilha.',
        'Corte tomate e pepino.',
        'Misture todos os ingredientes.',
        'Tempere com limão, azeite e sal.'
      ],
      minutes: 30,
      servings: 3,
      difficulty: 'Fácil',
      calories: 280),
  _recipe(
      id: 35,
      name: 'Salada de batata com ervas',
      category: 'Saladas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      description: 'Batatas macias com ervas frescas e molho leve.',
      ingredients: [
        '500 g de batata',
        '1/2 cebola roxa',
        'Salsinha e cebolinha',
        '2 colheres de azeite',
        'Limão e sal'
      ],
      steps: [
        'Cozinhe as batatas em cubos.',
        'Escorra e deixe amornar.',
        'Misture ervas, limão e azeite.',
        'Envolva as batatas no molho e sirva.'
      ],
      minutes: 30,
      servings: 4,
      difficulty: 'Fácil',
      calories: 260),
  _recipe(
      id: 36,
      name: 'Salada de rúcula e pera',
      category: 'Saladas',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999',
      description: 'Combinação agridoce de rúcula, pera, nozes e queijo.',
      ingredients: [
        '2 xícaras de rúcula',
        '1 pera',
        '50 g de nozes',
        '80 g de queijo branco',
        'Mel, limão e azeite'
      ],
      steps: [
        'Lave e seque a rúcula.',
        'Fatie a pera e corte o queijo.',
        'Misture mel, limão e azeite.',
        'Monte a salada e finalize com nozes.'
      ],
      minutes: 10,
      servings: 2,
      difficulty: 'Fácil',
      calories: 290),
  _recipe(
      id: 37,
      name: 'Salada de repolho cremosa',
      category: 'Saladas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      description: 'Repolho crocante com cenoura e molho cremoso de iogurte.',
      ingredients: [
        '2 xícaras de repolho',
        '1 cenoura',
        '1/2 maçã',
        'Iogurte natural',
        'Limão e sal'
      ],
      steps: [
        'Fatie o repolho e rale a cenoura.',
        'Corte a maçã em tiras.',
        'Misture iogurte, limão e sal.',
        'Combine e deixe gelar por 15 minutos.'
      ],
      minutes: 20,
      servings: 4,
      difficulty: 'Fácil',
      calories: 180),
  _recipe(
      id: 38,
      name: 'Salada de grãos',
      category: 'Saladas',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999',
      description: 'Mix de grãos, legumes e ervas para uma refeição nutritiva.',
      ingredients: [
        '1 xícara de quinoa cozida',
        '1/2 xícara de grão-de-bico',
        'Tomate-cereja',
        'Pepino',
        'Limão e azeite'
      ],
      steps: [
        'Cozinhe a quinoa e deixe esfriar.',
        'Misture com grão-de-bico e vegetais.',
        'Tempere com limão e azeite.',
        'Sirva em temperatura ambiente.'
      ],
      minutes: 25,
      servings: 3,
      difficulty: 'Fácil',
      calories: 340),
  _recipe(
      id: 39,
      name: 'Salada de beterraba e laranja',
      category: 'Saladas',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      description: 'Salada vibrante de beterraba assada e laranja.',
      ingredients: [
        '2 beterrabas',
        '2 laranjas',
        'Folhas verdes',
        'Queijo de cabra',
        'Azeite e vinagre'
      ],
      steps: [
        'Asse as beterrabas até ficarem macias.',
        'Descasque e corte as laranjas.',
        'Monte com as folhas e queijo.',
        'Tempere e sirva.'
      ],
      minutes: 50,
      servings: 3,
      difficulty: 'Fácil',
      calories: 230),
  _recipe(
      id: 40,
      name: 'Cheesecake de frutas vermelhas',
      category: 'Sobremesas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187',
      description: 'Cheesecake cremoso com calda de frutas vermelhas.',
      ingredients: [
        '200 g de biscoito',
        '80 g de manteiga',
        '400 g de cream cheese',
        '1/2 xícara de açúcar',
        'Frutas vermelhas'
      ],
      steps: [
        'Triture o biscoito e misture à manteiga.',
        'Pressione na forma e asse por 10 minutos.',
        'Bata cream cheese e açúcar e despeje sobre a base.',
        'Gele e cubra com frutas vermelhas.'
      ],
      minutes: 45,
      servings: 8,
      difficulty: 'Média',
      calories: 390),
  _recipe(
      id: 41,
      name: 'Torta de maçã',
      category: 'Sobremesas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1535920527002-b35e96722eb9',
      description: 'Torta aromática de maçã com canela e massa crocante.',
      ingredients: [
        '3 maçãs',
        '2 xícaras de farinha',
        '100 g de manteiga',
        '1/2 xícara de açúcar',
        'Canela'
      ],
      steps: [
        'Prepare uma massa com farinha, manteiga e açúcar.',
        'Fatie as maçãs e tempere com canela.',
        'Forre a forma, recheie e cubra.',
        'Asse a 180 °C por 40 minutos.'
      ],
      minutes: 70,
      servings: 8,
      difficulty: 'Média',
      calories: 360),
  _recipe(
      id: 42,
      name: 'Pudim de leite',
      category: 'Sobremesas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b',
      description: 'Pudim liso de leite com calda de caramelo.',
      ingredients: [
        '1 lata de leite condensado',
        '2 medidas de leite',
        '3 ovos',
        '1 xícara de açúcar'
      ],
      steps: [
        'Derreta o açúcar até formar caramelo.',
        'Bata leite condensado, leite e ovos.',
        'Despeje na forma caramelizada.',
        'Asse em banho-maria por 50 minutos e gele.'
      ],
      minutes: 70,
      servings: 8,
      difficulty: 'Média',
      calories: 280),
  _recipe(
      id: 43,
      name: 'Brownie de chocolate',
      category: 'Sobremesas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1564355808539-22fda35bed7e',
      description: 'Brownie úmido de chocolate com casquinha delicada.',
      ingredients: [
        '200 g de chocolate',
        '120 g de manteiga',
        '3 ovos',
        '1 xícara de açúcar',
        '3/4 de xícara de farinha'
      ],
      steps: [
        'Derreta chocolate e manteiga.',
        'Misture ovos e açúcar.',
        'Incorpore farinha e chocolate.',
        'Asse em forma pequena por 25 minutos.'
      ],
      minutes: 40,
      servings: 12,
      difficulty: 'Fácil',
      calories: 310),
  _recipe(
      id: 44,
      name: 'Cheesecake de limão',
      category: 'Sobremesas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b',
      description: 'Sobremesa cremosa e refrescante com limão.',
      ingredients: [
        '200 g de biscoito',
        '80 g de manteiga',
        '400 g de cream cheese',
        '1/2 xícara de açúcar',
        'Suco de 2 limões'
      ],
      steps: [
        'Faça a base com biscoito e manteiga.',
        'Bata cream cheese, açúcar e limão.',
        'Espalhe sobre a base.',
        'Gele por pelo menos 4 horas.'
      ],
      minutes: 30,
      servings: 8,
      difficulty: 'Fácil',
      calories: 340),
  _recipe(
      id: 45,
      name: 'Smoothie de banana e aveia',
      category: 'Bebidas',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888',
      description: 'Bebida cremosa de banana, aveia e canela.',
      ingredients: [
        '1 banana',
        '200 ml de leite',
        '2 colheres de aveia',
        'Canela e mel'
      ],
      steps: [
        'Coloque todos os ingredientes no liquidificador.',
        'Bata até ficar cremoso.',
        'Ajuste a doçura.',
        'Sirva imediatamente.'
      ],
      minutes: 5,
      servings: 1,
      difficulty: 'Fácil',
      calories: 250),
  _recipe(
      id: 46,
      name: 'Suco verde',
      category: 'Bebidas',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1610970881699-44a5587cabec',
      description: 'Suco refrescante de couve, maçã, limão e gengibre.',
      ingredients: [
        '1 folha de couve',
        '1 maçã',
        'Suco de 1 limão',
        '200 ml de água',
        'Gengibre a gosto'
      ],
      steps: [
        'Lave e corte os ingredientes.',
        'Bata tudo com água.',
        'Coe se desejar.',
        'Sirva com gelo.'
      ],
      minutes: 8,
      servings: 2,
      difficulty: 'Fácil',
      calories: 90),
  _recipe(
      id: 47,
      name: 'Chocolate quente cremoso',
      category: 'Bebidas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed',
      description: 'Chocolate quente encorpado para dias frios.',
      ingredients: [
        '500 ml de leite',
        '3 colheres de cacau',
        '2 colheres de açúcar',
        '1 colher de amido',
        'Canela'
      ],
      steps: [
        'Dissolva cacau e amido em um pouco de leite frio.',
        'Aqueça com o restante do leite.',
        'Mexa até engrossar.',
        'Adoce e sirva com canela.'
      ],
      minutes: 15,
      servings: 2,
      difficulty: 'Fácil',
      calories: 210),
  _recipe(
      id: 48,
      name: 'Limonada de morango',
      category: 'Bebidas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc',
      description: 'Limonada colorida com morangos frescos.',
      ingredients: [
        '4 limões',
        '1 xícara de morangos',
        '500 ml de água',
        'Açúcar ou mel e gelo'
      ],
      steps: [
        'Esprema os limões.',
        'Bata morangos com água.',
        'Misture os sucos e adoce.',
        'Sirva com bastante gelo.'
      ],
      minutes: 10,
      servings: 4,
      difficulty: 'Fácil',
      calories: 80),
  _recipe(
      id: 49,
      name: 'Vitamina de mamão',
      category: 'Bebidas',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888',
      description: 'Vitamina suave de mamão com leite e aveia.',
      ingredients: [
        '1/2 mamão',
        '250 ml de leite',
        '1 colher de aveia',
        'Mel a gosto'
      ],
      steps: [
        'Retire as sementes do mamão.',
        'Bata todos os ingredientes.',
        'Prove e ajuste o mel.',
        'Sirva gelado.'
      ],
      minutes: 5,
      servings: 2,
      difficulty: 'Fácil',
      calories: 180),
  _recipe(
      id: 50,
      name: 'Chá gelado de pêssego',
      category: 'Bebidas',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc',
      description: 'Chá gelado aromático com pêssego e limão.',
      ingredients: [
        '2 sachês de chá preto',
        '2 pêssegos',
        '500 ml de água',
        'Limão e gelo'
      ],
      steps: [
        'Prepare o chá e deixe esfriar.',
        'Bata um pêssego com parte da água.',
        'Misture ao chá e adicione limão.',
        'Sirva com gelo e fatias de pêssego.'
      ],
      minutes: 20,
      servings: 4,
      difficulty: 'Fácil',
      calories: 60),
  _recipe(
      id: 51,
      name: 'Café gelado',
      category: 'Bebidas',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735',
      description: 'Café gelado cremoso com leite e canela.',
      ingredients: [
        '200 ml de café forte',
        '100 ml de leite',
        'Gelo',
        'Canela e açúcar'
      ],
      steps: [
        'Prepare o café e deixe esfriar.',
        'Encha um copo com gelo.',
        'Adicione café e leite.',
        'Adoce e finalize com canela.'
      ],
      minutes: 10,
      servings: 1,
      difficulty: 'Fácil',
      calories: 90),
  _recipe(
      id: 52,
      name: 'Tapioca de frango',
      category: 'Lanches',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7',
      description: 'Tapioca recheada com frango desfiado e requeijão.',
      ingredients: [
        '3 colheres de goma de tapioca',
        '100 g de frango desfiado',
        '1 colher de requeijão',
        'Tomate e cheiro-verde'
      ],
      steps: [
        'Aqueça uma frigideira e espalhe a goma.',
        'Cozinhe até unir.',
        'Recheie com frango, requeijão e tomate.',
        'Dobre e sirva quente.'
      ],
      minutes: 15,
      servings: 1,
      difficulty: 'Fácil',
      calories: 300),
  _recipe(
      id: 53,
      name: 'Sanduíche natural de atum',
      category: 'Lanches',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af',
      description: 'Sanduíche fresco de atum, cenoura e folhas.',
      ingredients: [
        '2 fatias de pão integral',
        '1 lata de atum',
        '1 colher de iogurte',
        'Cenoura ralada e alface'
      ],
      steps: [
        'Escorra o atum.',
        'Misture com iogurte e cenoura.',
        'Espalhe no pão.',
        'Adicione alface, feche e corte.'
      ],
      minutes: 10,
      servings: 1,
      difficulty: 'Fácil',
      calories: 290),
  _recipe(
      id: 54,
      name: 'Bolinho de mandioca',
      category: 'Lanches',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7',
      description: 'Bolinho assado de mandioca com queijo.',
      ingredients: [
        '500 g de mandioca cozida',
        '100 g de queijo',
        '1 ovo',
        '2 colheres de farinha',
        'Sal e cheiro-verde'
      ],
      steps: [
        'Amasse a mandioca.',
        'Misture ovo, farinha e temperos.',
        'Recheie com queijo e modele.',
        'Asse a 200 °C até dourar.'
      ],
      minutes: 45,
      servings: 12,
      difficulty: 'Média',
      calories: 180),
  _recipe(
      id: 55,
      name: 'Pão de queijo',
      category: 'Lanches',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff',
      description: 'Pãezinhos de queijo dourados e macios por dentro.',
      ingredients: [
        '250 g de polvilho',
        '100 ml de leite',
        '50 ml de óleo',
        '1 ovo',
        '150 g de queijo ralado'
      ],
      steps: [
        'Ferva leite e óleo e escalde o polvilho.',
        'Quando amornar, misture ovo e queijo.',
        'Modele bolinhas.',
        'Asse a 200 °C por 25 minutos.'
      ],
      minutes: 40,
      servings: 20,
      difficulty: 'Média',
      calories: 120),
  _recipe(
      id: 56,
      name: 'Bruschetta de tomate',
      category: 'Lanches',
      mealType: 'Lanche',
      imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f',
      description: 'Fatias crocantes de pão com tomate, manjericão e azeite.',
      ingredients: [
        '1 baguete',
        '3 tomates',
        'Manjericão',
        '1 dente de alho',
        'Azeite e sal'
      ],
      steps: [
        'Corte e toste as fatias de pão.',
        'Esfregue alho no pão.',
        'Misture tomate, manjericão e azeite.',
        'Cubra os pães e sirva.'
      ],
      minutes: 20,
      servings: 6,
      difficulty: 'Fácil',
      calories: 160),
  _recipe(
      id: 57,
      name: 'Crepioca de queijo',
      category: 'Lanches',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93',
      description: 'Crepioca rápida com ovo, tapioca e queijo.',
      ingredients: [
        '1 ovo',
        '2 colheres de tapioca',
        '40 g de queijo',
        'Orégano e sal'
      ],
      steps: [
        'Bata o ovo com a tapioca.',
        'Despeje em frigideira antiaderente.',
        'Vire quando firmar.',
        'Recheie com queijo e dobre.'
      ],
      minutes: 10,
      servings: 1,
      difficulty: 'Fácil',
      calories: 260),
  _recipe(
      id: 58,
      name: 'Pão de banana e aveia',
      category: 'Outras',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a',
      description: 'Pão caseiro macio de banana e aveia.',
      ingredients: [
        '3 bananas',
        '2 ovos',
        '1 xícara de aveia',
        '1/2 xícara de farinha',
        '1 colher de fermento'
      ],
      steps: [
        'Amasse as bananas.',
        'Misture ovos, aveia e farinha.',
        'Incorpore o fermento.',
        'Asse em forma untada por 35 minutos.'
      ],
      minutes: 50,
      servings: 8,
      difficulty: 'Fácil',
      calories: 220),
  _recipe(
      id: 59,
      name: 'Ovos mexidos cremosos',
      category: 'Outras',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8',
      description: 'Ovos mexidos macios para um café da manhã rápido.',
      ingredients: [
        '3 ovos',
        '1 colher de manteiga',
        '2 colheres de leite',
        'Sal e cebolinha'
      ],
      steps: [
        'Bata os ovos com leite e sal.',
        'Derreta a manteiga em fogo baixo.',
        'Mexa os ovos lentamente até cremosos.',
        'Finalize com cebolinha.'
      ],
      minutes: 10,
      servings: 2,
      difficulty: 'Fácil',
      calories: 210),
  _recipe(
      id: 60,
      name: 'Arroz de forno com legumes',
      category: 'Outras',
      mealType: 'Almoço',
      imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19',
      description: 'Arroz gratinado com legumes e queijo.',
      ingredients: [
        '3 xícaras de arroz cozido',
        '1 cenoura',
        '1/2 xícara de ervilha',
        '1/2 xícara de milho',
        '150 g de muçarela'
      ],
      steps: [
        'Misture arroz, legumes e temperos.',
        'Transfira para um refratário.',
        'Cubra com muçarela.',
        'Asse até gratinar.'
      ],
      minutes: 35,
      servings: 5,
      difficulty: 'Fácil',
      calories: 330),
  _recipe(
      id: 61,
      name: 'Cuscuz nordestino',
      category: 'Outras',
      mealType: 'Café da manhã',
      imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19',
      description: 'Cuscuz de milho hidratado, soltinho e saboroso.',
      ingredients: [
        '2 xícaras de flocão de milho',
        '1 xícara de água',
        '1 colher de manteiga',
        'Sal'
      ],
      steps: [
        'Hidrate o flocão com água e sal.',
        'Descanse por 10 minutos.',
        'Cozinhe no cuscuzeiro por 15 minutos.',
        'Finalize com manteiga.'
      ],
      minutes: 25,
      servings: 4,
      difficulty: 'Fácil',
      calories: 240),
  _recipe(
      id: 62,
      name: 'Risoto de legumes',
      category: 'Outras',
      mealType: 'Jantar',
      imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371',
      description: 'Risoto cremoso de arroz arbóreo com legumes frescos.',
      ingredients: [
        '1 xícara de arroz arbóreo',
        '1 cenoura',
        '1 abobrinha',
        '1 litro de caldo de legumes',
        'Parmesão e manteiga'
      ],
      steps: [
        'Refogue o arroz em manteiga.',
        'Adicione o caldo aos poucos, mexendo sempre.',
        'Junte os legumes no meio do cozimento.',
        'Finalize com parmesão e sirva cremoso.'
      ],
      minutes: 45,
      servings: 3,
      difficulty: 'Média',
      calories: 380),
];
