import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  AuthController._();

  static final instance = AuthController._();

  SharedPreferences? _prefs;
  bool _initialized = false;
  bool _loggedIn = false;
  String _name = '';
  String _email = '';

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  String get name => _name;
  String get email => _email;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _name = _prefs?.getString('user_name') ?? '';
    _email = _prefs?.getString('user_email') ?? '';
    _loggedIn = _prefs?.getBool('session_active') ?? false;
    _initialized = true;
    notifyListeners();
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (name.trim().isEmpty || normalizedEmail.isEmpty || password.isEmpty) {
      return 'Preencha todos os campos.';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(normalizedEmail)) {
      return 'Digite um e-mail válido.';
    }
    if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    await _prefs?.setString('user_name', name.trim());
    await _prefs?.setString('user_email', normalizedEmail);
    await _prefs?.setString('user_password', password);
    await _prefs?.setBool('session_active', true);
    _name = name.trim();
    _email = normalizedEmail;
    _loggedIn = true;
    notifyListeners();
    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final savedEmail = _prefs?.getString('user_email');
    final savedPassword = _prefs?.getString('user_password');
    if (savedEmail == null || savedPassword == null) {
      return 'Nenhuma conta cadastrada neste dispositivo.';
    }
    if (email.trim().toLowerCase() != savedEmail || password != savedPassword) {
      return 'E-mail ou senha incorretos.';
    }
    _loggedIn = true;
    await _prefs?.setBool('session_active', true);
    notifyListeners();
    return null;
  }

  Future<void> updateUser({required String name, required String email}) async {
    _name = name.trim();
    _email = email.trim().toLowerCase();
    await _prefs?.setString('user_name', _name);
    await _prefs?.setString('user_email', _email);
    notifyListeners();
  }

  Future<void> logout() async {
    _loggedIn = false;
    await _prefs?.setBool('session_active', false);
    notifyListeners();
  }

  Future<void> clearAccountData() async {
    await _prefs?.clear();
    _name = '';
    _email = '';
    _loggedIn = false;
    notifyListeners();
  }
}
