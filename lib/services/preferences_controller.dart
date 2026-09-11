import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends ChangeNotifier {
  PreferencesController._();

  static final instance = PreferencesController._();
  SharedPreferences? _prefs;
  final Set<String> _selected = {};

  static const options = [
    'Vegetariana',
    'Vegana',
    'Sem lactose',
    'Sem glúten',
    'Alta proteína',
    'Baixo carboidrato',
  ];

  Set<String> get selected => Set.unmodifiable(_selected);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _selected
      ..clear()
      ..addAll(_prefs?.getStringList('food_preferences') ?? []);
    notifyListeners();
  }

  Future<void> toggle(String option) async {
    if (!_selected.add(option)) _selected.remove(option);
    await _prefs?.setStringList('food_preferences', _selected.toList());
    notifyListeners();
  }
}
