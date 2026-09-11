import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsController extends ChangeNotifier {
  NotificationsController._();

  static final instance = NotificationsController._();
  SharedPreferences? _prefs;
  final Map<String, bool> _values = {
    'general': true,
    'newRecipes': true,
    'recommended': true,
    'reminders': false,
  };

  bool get(String key) => _values[key] ?? false;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    for (final key in _values.keys) {
      _values[key] = _prefs?.getBool('notification_$key') ?? _values[key]!;
    }
    notifyListeners();
  }

  Future<void> set(String key, bool value) async {
    _values[key] = value;
    await _prefs?.setBool('notification_$key', value);
    notifyListeners();
  }
}
