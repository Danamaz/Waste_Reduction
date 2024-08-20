import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  final lightThemeAppBarColor = const Color(0xFFE7E6EB);
  final lightThemeBackgroundColor = const Color(0xFFF7F6F9);

  final darkThemeAppBarColor = const Color(0xFF2E2A31);
  final darkThemeBackgroundColor = const Color(0xFF1A171D);

  final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ).copyWith(
      background: const Color(0xFFF7F6F9),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE7E6EB),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFE7E6EB),
    ),
  );

  final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ).copyWith(
      background: const Color(0xFF1A171D),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E2A31),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2E2A31),
    ),
  );

  // Dark mode toggle action
  void changeTheme() {
    _isDark = !_isDark;

    // Save the value to secure storage
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  // Init method of provider
  Future<void> init() async {
    // After we re-run the app
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark") ?? false;
    notifyListeners();
  }
}
