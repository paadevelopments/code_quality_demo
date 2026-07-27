import 'package:code_quality_demo/core/resources/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

/// Defines the visual theme for the application.
class AppTheme {
  AppTheme._();

  /// Configuration for the light theme.
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: AppFonts.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      );

  /// Configuration for the dark theme.
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppFonts.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      );
}
