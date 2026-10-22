import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> initializeTheme() async => _load();

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('themeMode')) {
      final val = prefs.getString('themeMode');
      themeMode = val == 'dark' ? ThemeMode.dark : val == 'light' ? ThemeMode.light : ThemeMode.system;
    } else if (prefs.containsKey('isDarkMode')) {
      // Migrate old bool key once
      final old = prefs.getBool('isDarkMode') ?? false;
      themeMode = old ? ThemeMode.dark : ThemeMode.light;
      await prefs.setString('themeMode', old ? 'dark' : 'light');
      await prefs.remove('isDarkMode');
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode == ThemeMode.dark ? 'dark' : mode == ThemeMode.light ? 'light' : 'system');
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
