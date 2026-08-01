import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:flutter/material.dart';

/// Provides imperative navigation methods using a global key.
class AppNavigator {
  AppNavigator._();

  /// Key used to access the navigator state from anywhere.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Pushes a new route onto the stack.
  static Future<T?> push<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed<T>(routeName, arguments: arguments);
  }

  /// Removes the current route from the stack.
  static void pop<T>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  /// Replaces the current route with a new one.
  static Future<T?> replace<T, TO>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  /// Navigates to a specific route and clears stack.
  static Future<T?> pushAndRemoveUntil<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigates to the home (posts) screen and clears stack.
  static Future<T?> goHome<T>() {
    return pushAndRemoveUntil<T>(AppRoutes.posts);
  }

  /// Navigates to the login screen and clears stack.
  static Future<T?> toLogin<T>() {
    return pushAndRemoveUntil<T>(AppRoutes.login);
  }
}
