import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController._();

  static final instance = FavoritesController._();

  SharedPreferences? _prefs;
  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => Set.unmodifiable(_favoriteIds);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _favoriteIds
      ..clear()
      ..addAll(
          _prefs?.getStringList('favorite_recipe_ids')?.map(int.parse) ?? []);
    notifyListeners();
  }

  bool isFavorite(int recipeId) => _favoriteIds.contains(recipeId);

  Future<void> toggle(int recipeId) async {
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
    } else {
      _favoriteIds.add(recipeId);
    }

    await _prefs?.setStringList(
      'favorite_recipe_ids',
      _favoriteIds.map((id) => id.toString()).toList(),
    );
    notifyListeners();
  }

  Future<void> clear() async {
    _favoriteIds.clear();
    await _prefs?.remove('favorite_recipe_ids');
    notifyListeners();
  }
}
