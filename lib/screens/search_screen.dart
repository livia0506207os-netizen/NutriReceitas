import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/recipe.dart';
import '../theme/app_colors.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String category = 'Todas';
  String difficulty = 'Todas';
  int? maxMinutes;

  final categories = const [
    'Todas',
    'Café da manhã',
    'Almoço',
    'Jantar',
    'Saladas',
    'Lanches',
    'Sobremesas',
    'Bebidas',
    'Carnes',
    'Massas',
    'Outras',
  ];

  List<Recipe> get filtered {
    final query = controller.text.trim().toLowerCase();

    return recipes.where((recipe) {
      final nameMatch = recipe.name.toLowerCase().contains(query);
      final categoryMatch = category == 'Todas' ||
          recipe.category.toLowerCase().contains(category.toLowerCase()) ||
          recipe.name.toLowerCase().contains(category.toLowerCase());
      final difficultyMatch =
          difficulty == 'Todas' || recipe.difficulty == difficulty;
      final timeMatch = maxMinutes == null || recipe.minutes <= maxMinutes!;
      return nameMatch && categoryMatch && difficultyMatch && timeMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = filtered;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(14, 24, 14, 28),
        children: [
          const Text(
            'Buscar receitas',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Buscar receitas...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: controller.clear,
                      icon: const Icon(Icons.close),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Sugestões',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: categories.map((item) {
              final active = category == item;
              return ChoiceChip(
                label: Text(item),
                selected: active,
                onSelected: (_) => setState(() => category = item),
                selectedColor: AppColors.softGreen,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Filtros',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _filterChip(
                label: maxMinutes == null ? 'Tempo' : 'Até $maxMinutes min',
                onTap: () => _chooseTime(),
              ),
              _filterChip(
                label: difficulty == 'Todas' ? 'Dificuldade' : difficulty,
                onTap: () => _chooseDifficulty(),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            'Resultados (${results.length})',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          if (results.isEmpty)
            _emptyState()
          else
            ...results.map(
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
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      avatar: const Icon(Icons.tune, size: 18),
    );
  }

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.muted),
          SizedBox(height: 16),
          Text(
            'Nenhuma receita encontrada',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Não encontramos receitas para sua busca. Tente utilizar outros termos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseTime() async {
    final selected = await showModalBottomSheet<int?>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Qualquer tempo'),
              onTap: () => Navigator.pop(context, null),
            ),
            ListTile(
              title: const Text('Até 15 minutos'),
              onTap: () => Navigator.pop(context, 15),
            ),
            ListTile(
              title: const Text('Até 30 minutos'),
              onTap: () => Navigator.pop(context, 30),
            ),
            ListTile(
              title: const Text('Até 60 minutos'),
              onTap: () => Navigator.pop(context, 60),
            ),
          ],
        ),
      ),
    );
    setState(() => maxMinutes = selected);
  }

  Future<void> _chooseDifficulty() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in ['Todas', 'Fácil', 'Média', 'Difícil'])
              ListTile(
                title: Text(item),
                onTap: () => Navigator.pop(context, item),
              ),
          ],
        ),
      ),
    );
    if (selected != null) {
      setState(() => difficulty = selected);
    }
  }
}
