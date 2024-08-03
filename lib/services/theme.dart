import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  // colorScheme: const ColorScheme.light().copyWith(
  //   background: Colors.grey.shade400,
  //   // primary: Colors.grey.shade300,
  //   // secondary: Colors.grey.shade200,
  // ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  // colorScheme: const ColorScheme.dark().copyWith(
  //   background: Colors.grey.shade900,
  //   // primary: Colors.grey.shade800,
  //   // secondary: Colors.grey.shade700,
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
