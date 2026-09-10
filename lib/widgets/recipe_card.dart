import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/favorites_controller.dart';
import '../theme/app_colors.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.softGray,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.55,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.softGreen,
                        child: const Icon(Icons.restaurant, size: 40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: AnimatedBuilder(
                    animation: FavoritesController.instance,
                    builder: (_, __) => Material(
                      color: Colors.white.withValues(alpha: 0.88),
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: 'Favoritar',
                        onPressed: () =>
                            FavoritesController.instance.toggle(recipe.id),
                        icon: Icon(
                          FavoritesController.instance.isFavorite(recipe.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.schedule_outlined, size: 18),
                      const SizedBox(width: 5),
                      Text('${recipe.minutes} min'),
                      const SizedBox(width: 18),
                      const Icon(Icons.local_fire_department_outlined, size: 18),
                      const SizedBox(width: 4),
                      Text('~${recipe.calories} kcal'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
