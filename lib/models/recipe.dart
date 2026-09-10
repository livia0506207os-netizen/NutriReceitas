class Recipe {
  final int id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final int minutes;
  final int servings;
  final String difficulty;
  final int calories;
  final String mealType;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.minutes,
    required this.servings,
    required this.difficulty,
    required this.calories,
    required this.mealType,
  });
}
