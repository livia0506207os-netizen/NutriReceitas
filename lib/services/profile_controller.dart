import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  ProfileController._();

  static final instance = ProfileController._();

  SharedPreferences? _prefs;
  Uint8List? _photoBytes;

  Uint8List? get photoBytes => _photoBytes;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final encoded = _prefs?.getString('profile_photo');
    if (encoded != null && encoded.isNotEmpty) {
      _photoBytes = base64Decode(encoded);
    }
    notifyListeners();
  }

  Future<void> savePhoto(Uint8List bytes) async {
    _photoBytes = bytes;
    await _prefs?.setString('profile_photo', base64Encode(bytes));
    notifyListeners();
  }
}
