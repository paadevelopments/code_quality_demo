import 'package:code_quality_demo/core/data/services/storage_service.dart';
import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/base_viewmodel.dart';
import 'package:flutter/material.dart';

/// Manages application-wide localization and translation.
class LocalizationViewModel extends BaseViewModel {
  /// Global singleton instance.
  static final LocalizationViewModel instance =
      LocalizationViewModel._internal();
  LocalizationViewModel._internal();

  final StorageService _storage = StorageService.instance;
  static const String _localeKey = 'app_locale';

  Locale _locale = const Locale('en');

  /// Gets the current locale.
  Locale get locale => _locale;

  final Map<String, Map<String, String>> _translations = {
    'en': {
      AppStrings.appName: 'Posts App',
      AppStrings.loading: 'Loading...',
      AppStrings.success: 'Success',
      AppStrings.error: 'Error',
      AppStrings.ok: 'OK',
      AppStrings.login: 'Login',
      AppStrings.email: 'Email',
      AppStrings.password: 'Password',
      AppStrings.postsLoaded: 'Posts loaded successfully',
      AppStrings.liked: 'Liked!',
      AppStrings.likeAndReturn: 'Like Post & Return',
      AppStrings.resultFromDetails: 'Result from details: ',
    },
    'fr': {
      AppStrings.appName: 'Application de Messages',
      AppStrings.loading: 'Chargement...',
      AppStrings.success: 'Succès',
      AppStrings.error: 'Erreur',
      AppStrings.ok: "D'accord",
      AppStrings.login: 'Connexion',
      AppStrings.email: 'Email',
      AppStrings.password: 'Mot de passe',
      AppStrings.postsLoaded: 'Messages chargés avec succès',
      AppStrings.liked: 'Aimé !',
      AppStrings.likeAndReturn: 'Aimer et revenir',
      AppStrings.resultFromDetails: 'Résultat des détails : ',
    },
  };

  /// Initializes the locale from storage.
  Future<void> init() async {
    final savedLocale = await _storage.read(_localeKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
      refresh();
    }
  }

  /// Sets the application locale.
  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode == 'en' || locale.languageCode == 'fr') {
      _locale = locale;
      await _storage.write(_localeKey, locale.languageCode);
      refresh();
    }
  }

  /// Translates a key based on the current locale.
  String translate(String key) {
    return _translations[_locale.languageCode]?[key] ?? key;
  }
}
