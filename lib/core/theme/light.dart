// core/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFC53030);
  static const Color onBoardingColor = Color(0xFF8A8CA2);
  static const Color backgroundColor = Colors.white;
  static const Color darkGradientColor = Colors.black;
  static const Color errorColor = Colors.red;
  static const Color disabledColor = Colors.grey;
  static const Color whiteBgColor = Color(0xFFFAFAFA);
  static const Color skipBtnColor = Color(0xFFD32F2F);
  static const Color graySearchColor = Color(0xFF6D6D6D);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        surface: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSurface: Colors.black,
        onSecondary: Colors.white70,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: Colors.white,
        ),
        headlineMedium: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white70,
        ),

        labelLarge:TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF484A5A),
        ),

        labelMedium:  TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: onBoardingColor,
        ),

        labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: graySearchColor,
        ),


      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 16,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      splashFactory: NoSplash.splashFactory,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Color(0xFFC53030),
          foregroundColor: Color(0xFFFFFCFC),
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xFF363636)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }

  static ThemeData getTheme({required bool isDarkMode}) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
