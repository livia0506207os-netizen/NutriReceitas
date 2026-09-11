import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../services/favorites_controller.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
        animation: FavoritesController.instance,
        builder: (context, _) {
          final favorites = recipes
              .where((recipe) =>
                  FavoritesController.instance.favoriteIds.contains(recipe.id))
              .toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 30, 18, 30),
            children: [
              const Text(
                'Meus favoritos',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              const Text(
                'Suas receitas favoritas em um só lugar',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),
              if (favorites.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 130),
                  child: Column(
                    children: [
                      Icon(Icons.favorite_border, size: 72),
                      SizedBox(height: 16),
                      Text(
                        'Você ainda não salvou receitas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Toque no coração de uma receita para adicioná-la aos favoritos.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...favorites.map(
                  (recipe) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RecipeCard(
                      recipe: recipe,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
