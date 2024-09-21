import 'package:flutter/material.dart';

class AppTypography {
  static const String defaultFont = "GoogleSans";

  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontFamily: defaultFont,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    headlineLarge: TextStyle(
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFont,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFont,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFont,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFont,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
      fontFamily: defaultFont,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
      fontFamily: defaultFont,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: defaultFont,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
      fontFamily: defaultFont,
    ),
  );
}
