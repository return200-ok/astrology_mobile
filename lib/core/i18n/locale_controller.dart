import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  static const String _prefKey = 'app_locale';
  static const String _systemValue = 'system';

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawValue = prefs.getString(_prefKey);
      _locale = _fromStorageValue(rawValue);
    } catch (_) {
      // Fallback to system locale silently — app remains usable
      _locale = null;
    }
  }

  /// Returns true on success, false if persisting to storage failed.
  /// The in-memory locale is always updated immediately.
  Future<bool> setSystemLocale() async {
    _locale = null;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, _systemValue);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Returns true on success, false if persisting to storage failed.
  /// The in-memory locale is always updated immediately.
  Future<bool> setLocaleCode(String code) async {
    _locale = Locale(code);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, code);
      return true;
    } catch (_) {
      return false;
    }
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
