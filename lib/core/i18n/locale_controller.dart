import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  static const String _prefKey = 'app_locale';
  static const String _systemValue = 'system';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final rawValue = prefs.getString(_prefKey);
    _locale = _fromStorageValue(rawValue);
  }

  Future<void> setSystemLocale() async {
    _locale = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, _systemValue);
  }

  Future<void> setLocaleCode(String code) async {
    final locale = Locale(code);
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, code);
  }

  String get selectedCode => _locale?.languageCode ?? _systemValue;

  Locale? _fromStorageValue(String? value) {
    if (value == null || value == _systemValue) {
      return null;
    }
    if (value == 'en' || value == 'vi') {
      return Locale(value);
    }
    return null;
  }
}
