import 'package:flutter_test/flutter_test.dart';

import 'package:nutri_receitas/data/mock_data.dart';

void main() {
  test('dados mockados possuem receitas suficientes', () {
    expect(recipes.length, greaterThanOrEqualTo(10));
  });

  test('bolo de banana possui dados completos', () {
    final recipe = recipes.first;

    expect(recipe.name, 'Bolo de banana');
    expect(recipe.ingredients, isNotEmpty);
    expect(recipe.steps, isNotEmpty);
    expect(recipe.minutes, greaterThan(0));
    expect(recipe.servings, greaterThan(0));
  });
}
