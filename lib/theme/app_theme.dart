import 'package:flutter/material.dart';

class AppTheme {
  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkDivider = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkIcon = Color(0xFFBBBBBB);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightIcon = Color(0xFF757575);

  static const Color incomeGreen = Color(0xFF22C55E);
  static const Color expenseRed = Color(0xFFEF4444);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: Colors.grey[700],
    colorScheme: const ColorScheme.light(
      primary: Colors.grey,
      secondary: Colors.grey,
      surface: lightSurface,
      background: lightBackground,
      error: Color(0xFFD32F2F),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: lightTextPrimary,
      onBackground: lightTextPrimary,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: lightTextPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightTextSecondary,
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: Colors.grey[300],
        selectedForegroundColor: lightTextPrimary,
        backgroundColor: Colors.grey[200],
        foregroundColor: lightTextSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      labelStyle: const TextStyle(color: lightTextSecondary),
      hintStyle: const TextStyle(color: lightTextSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: lightTextPrimary,
      iconColor: lightIcon,
    ),
    iconTheme: const IconThemeData(
      color: lightIcon,
    ),
    dividerTheme: DividerThemeData(
      color: lightDivider,
      thickness: 1,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: lightTextPrimary),
      displayMedium: TextStyle(color: lightTextPrimary),
      displaySmall: TextStyle(color: lightTextPrimary),
      headlineLarge: TextStyle(color: lightTextPrimary),
      headlineMedium: TextStyle(color: lightTextPrimary),
      headlineSmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: lightTextPrimary),
      titleMedium: TextStyle(color: lightTextPrimary),
      titleSmall: TextStyle(color: lightTextPrimary),
      bodyLarge: TextStyle(color: lightTextPrimary),
      bodyMedium: TextStyle(color: lightTextSecondary),
      bodySmall: TextStyle(color: lightTextSecondary),
      labelLarge: TextStyle(color: lightTextPrimary),
      labelMedium: TextStyle(color: lightTextSecondary),
      labelSmall: TextStyle(color: lightTextSecondary),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: const Color(0xFF3A3A3A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3A3A3A),
      secondary: Color(0xFF4A4A4A),
      surface: darkSurface,
      background: darkBackground,
      error: Color(0xFFCF6679),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A3A3A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFBBBBBB),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: const Color(0xFF3A3A3A),
        selectedForegroundColor: Colors.white,
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white70,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
      ),
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white54),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Color(0xFFBBBBBB),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFBBBBBB),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2C2C2C),
      thickness: 1,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white70),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white70),
      labelSmall: TextStyle(color: Colors.white70),
    ),
  );
}