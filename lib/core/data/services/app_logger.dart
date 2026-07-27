import 'package:flutter/foundation.dart';

/// Simple utility for application logging.
class AppLogger {
  AppLogger._();

  /// Logs a message in debug mode.
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[LOG] $message');
    }
  }

  /// Logs an error in debug mode.
  static void error(String message, [dynamic error]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message: $error');
    }
  }
}
