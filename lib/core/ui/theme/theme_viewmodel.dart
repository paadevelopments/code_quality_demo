import 'package:code_quality_demo/core/data/services/storage_service.dart';
import 'package:code_quality_demo/core/ui/base_viewmodel.dart';
import 'package:flutter/material.dart';

/// Manages application-wide theme mode (light/dark).
class ThemeViewModel extends BaseViewModel {
  /// Global singleton instance.
  static final ThemeViewModel instance = ThemeViewModel._internal();
  ThemeViewModel._internal();

  final StorageService _storage = StorageService.instance;
  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;

  /// Gets the current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Whether the current theme is dark.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Initializes the theme from storage.
  Future<void> init() async {
    final savedTheme = await _storage.read(_themeKey);
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      refresh();
    }
  }

  /// Toggles the application theme.
  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _storage.write(_themeKey, isDarkMode ? 'dark' : 'light');
    refresh();
  }
}
