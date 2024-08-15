import 'package:flutter/material.dart';

const Color seedColor = Color(0xFF6200EE);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[100],
    foregroundColor: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  ),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Colors.grey[800],
  //   foregroundColor: Colors.white,
  // ),
);

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? darkMode : lightMode;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
