import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: AppTypography.defaultFont,
    textTheme: AppTypography.textTheme,
    filledButtonTheme: _filledButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    visualDensity: VisualDensity.standard,
    iconTheme: IconThemeData(
      color: lightColorScheme.onSurface,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: AppTypography.defaultFont,
    textTheme: AppTypography.textTheme,
    filledButtonTheme: _filledButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    visualDensity: VisualDensity.standard,
    iconTheme: IconThemeData(
      color: darkColorScheme.onSurface,
    ),
    cardTheme: CardTheme(
      color: darkColorScheme.onInverseSurface,
    ),
  );

  static final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(borderRadius: _defaultBorderRadius),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20), //28
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 1.5,
        ),
      ),
    ),
  );

  static const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
    ),
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(16),
  );

  static const BorderRadius _defaultBorderRadius = BorderRadius.all(
    Radius.circular(8.0),
  );
}
