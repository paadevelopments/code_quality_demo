import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:code_quality_demo/core/ui/navigation/not_found_screen.dart';
import 'package:code_quality_demo/features/auth/ui/login/screen.dart';
import 'package:code_quality_demo/features/posts/ui/details/screen.dart';
import 'package:code_quality_demo/features/posts/ui/list/screen.dart';
import 'package:code_quality_demo/features/splash/ui/screen.dart';
import 'package:flutter/material.dart';

/// Configures and handles the generation of application routes.
class AppRouter {
  AppRouter._();

  /// Entry point for dynamic route generation.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
      case AppRoutes.root:
        return _buildRoute(const SplashScreen(), settings);
      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);
      case AppRoutes.posts:
        return _buildRoute(const PostsScreen(), settings);
      case AppRoutes.postDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(PostDetailsScreen(arguments: args), settings);
      default:
        return _buildRoute(
          NotFoundScreen(routeName: settings.name),
          settings,
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget child, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => child,
      settings: settings,
    );
  }
}
