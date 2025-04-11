import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimaryColor = Color(0xFF6200EE);
  static const Color lightSecondaryColor = Color(0xFF03DAC6);
  static const Color darkPrimaryColor = Color(0xFFBB86FC);
  static const Color darkSecondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);
  
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: lightPrimaryColor,
      colorScheme: const ColorScheme.light(
        primary: lightPrimaryColor,
        secondary: lightSecondaryColor,
        error: errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: lightSecondaryColor,
        foregroundColor: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardTheme: const CardTheme(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: darkPrimaryColor,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        error: errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: darkPrimaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkSecondaryColor,
        foregroundColor: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: const CardTheme(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Color(0xFF1E1E1E),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
    );
  }
}
