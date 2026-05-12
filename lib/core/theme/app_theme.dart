import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF121212),

    primaryColor: const Color(0xFF4B7BEC),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4B7BEC),
      surface: Color(0xFF1E1E1E),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4B7BEC),
      foregroundColor: Colors.white,
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFB0B0B0),
      ),
    ),
  );
}