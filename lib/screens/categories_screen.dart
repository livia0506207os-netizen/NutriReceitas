import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final String? initialCategory;

  const CategoriesScreen({super.key, this.initialCategory});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late String selected;

  final categories = const [
    'Todas',
    'Massas',
    'Carnes',
    'Saladas',
    'Sobremesas',
    'Bebidas',
    'Lanches',
    'Outras',
  ];

  @override
  void initState() {
    super.initState();
    selected = widget.initialCategory ?? 'Todas';
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selected == 'Todas'
        ? recipes
        : recipes.where((r) => r.category == selected || r.mealType == selected).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Receitas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              final active = selected == category;
              return ChoiceChip(
                label: Text(category),
                selected: active,
                onSelected: (_) => setState(() => selected = category),
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: active ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ...filtered.map(
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
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: Text('Nenhuma receita encontrada.')),
            ),
        ],
      ),
    );
  }
}
