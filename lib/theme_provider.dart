import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  ThemeMode _themMode = ThemeMode.dark;

  ThemeMode get themeMode => _themMode;

  void toggleTheme() {
    if (_themMode == ThemeMode.dark) {
      _themMode = ThemeMode.light;
    } else {
      _themMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
