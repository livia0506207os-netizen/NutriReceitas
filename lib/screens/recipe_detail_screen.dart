import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/favorites_controller.dart';
import '../theme/app_colors.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 253,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.softGreen),
              ),
            ),
            actions: [
              AnimatedBuilder(
                animation: FavoritesController.instance,
                builder: (_, __) {
                  final favorite =
                      FavoritesController.instance.isFavorite(recipe.id);
                  return IconButton(
                    onPressed: () =>
                        FavoritesController.instance.toggle(recipe.id),
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _InfoRow(recipe: recipe),
                const SizedBox(height: 28),
                Text(
                  recipe.description,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Ingredientes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...recipe.ingredients.map(
                  (item) => _BulletRow(text: item),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Modo de preparo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...recipe.steps.asMap().entries.map(
                  (entry) => _StepRow(
                    number: entry.key + 1,
                    text: entry.value,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Começar receita'),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final Recipe recipe;

  const _InfoRow({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.schedule_outlined, '${recipe.minutes} min', 'Tempo'),
      (Icons.restaurant_outlined, recipe.difficulty, 'Dificuldade'),
      (Icons.local_fire_department_outlined, '~${recipe.calories} kcal', 'Calorias'),
      (Icons.people_outline, '${recipe.servings}', 'Quantidade'),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Icon(items[i].$1, size: 21),
                const SizedBox(height: 5),
                Text(
                  items[i].$2,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                Text(
                  items[i].$3,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          if (i < items.length - 1)
            Container(width: 1, height: 40, color: Colors.black12),
        ],
      ],
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;

  const _BulletRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 21),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;

  const _StepRow({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.softGreen,
            child: Text(
              '$number',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
