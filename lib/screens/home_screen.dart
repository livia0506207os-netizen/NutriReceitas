import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/category_card.dart';
import '../widgets/recipe_card.dart';
import 'categories_screen.dart';
import 'recipe_detail_screen.dart';
import 'search_screen.dart';
import '../services/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      (
        'Café da manhã',
        Icons.free_breakfast_outlined,
        AppColors.softYellow,
        'Café da manhã'
      ),
      ('Almoço', Icons.restaurant_menu, AppColors.softGreen2, 'Almoço'),
      ('Jantar', Icons.ramen_dining, AppColors.softGreen, 'Jantar'),
      ('Sobremesa', Icons.cake_outlined, AppColors.softPink, 'Sobremesas'),
      ('Saladas', Icons.rice_bowl_outlined, AppColors.softGreen, 'Saladas'),
      ('Lanches', Icons.lunch_dining_outlined, AppColors.softYellow, 'Lanches'),
    ];

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = constraints.maxWidth > 600 ? 48.0 : 28.0;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontal, 24, horizontal, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedBuilder(
                                animation: AuthController.instance,
                                builder: (_, __) => Text(
                                      'Olá, ${AuthController.instance.name}!',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: AppColors.softGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.eco_outlined),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'O que vamos preparar hoje?',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 26),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SearchScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: const Row(
                            children: [
                              Icon(Icons.search, size: 22),
                              SizedBox(width: 10),
                              Text(
                                'Buscar receitas...',
                                style: TextStyle(
                                  color: AppColors.placeholder,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          const Text(
                            'Categorias',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CategoriesScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Ver todas >',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontal),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = categories[index];
                      return CategoryCard(
                        label: item.$1,
                        icon: item.$2,
                        background: item.$3,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoriesScreen(
                                initialCategory: item.$4,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: categories.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 6 : 3,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.95,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontal, 26, horizontal, 22),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Receitas em destaque',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontal),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final recipe = recipes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: RecipeCard(
                          recipe: recipe,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }
}
