import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/localization/localization_viewmodel.dart';
import 'package:code_quality_demo/core/ui/navigation/app_navigator.dart';
import 'package:code_quality_demo/core/ui/navigation/app_router.dart';
import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:code_quality_demo/core/ui/theme/app_theme.dart';
import 'package:code_quality_demo/core/ui/theme/theme_viewmodel.dart';
import 'package:code_quality_demo/features/auth/ui/auth_viewmodel.dart';
import 'package:flutter/material.dart';

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates the application widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// DO NOT DO ANY MULI-PROVIDER WRAPPING HERE.
    /// All view models should be declared as `Global singleton instance`.

    /// This is just for view models that are needed for the
    /// `MaterialApp` initialization.
    return ListenableBuilder(
      listenable: Listenable.merge([
        AuthViewModel.instance,
        ThemeViewModel.instance,
        LocalizationViewModel.instance,
      ]),
      builder: (context, _) {
        return MaterialApp(
          key: ValueKey(AuthViewModel.instance.isAuthenticated),
          title: AppStrings.appName,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeViewModel.instance.themeMode,
          locale: LocalizationViewModel.instance.locale,
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
