//https://api.flutter.dev/flutter/material/TextTheme-class.html
import 'package:flutter/material.dart';
import 'package:modular_themes/modular_themes.dart';


abstract class AppThemes {
  const AppThemes({
    required this.themeMode,
    required this.appColors,
    required this.fontName,
  });
  final ThemeMode themeMode;
  final AppColors appColors;
  final String fontName;

  ThemeData get lightTheme;
  ThemeData get darkTheme;

  ThemeData get selectedTheme =>
      themeMode == ThemeMode.light ? lightTheme : darkTheme;

  factory AppThemes.init({
    required ThemeMode themeMode,
    required AppFonts font,
  }) {
    return AppThemesImpl(
      themeMode: themeMode,
      fontName: font.fontName,
      appColors: AppColors.init(themeMode),
    );
  }

  TextTheme myTextTheme(Color color) => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color,
            wordSpacing: 0.15),
        titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
            wordSpacing: 0.1),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
            wordSpacing: 0.1),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
            wordSpacing: 0.5),
        labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
            wordSpacing: 0.5),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: color,
            wordSpacing: 0.15),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
            wordSpacing: 0.25),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
            wordSpacing: 0.4),
      );
}
