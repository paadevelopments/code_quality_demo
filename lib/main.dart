import 'package:code_quality_demo/app.dart';
import 'package:flutter/material.dart';

/// The entry point of the Flutter application.
void main() {
  /// DO NOT RUN ANY ASYNC AWAIT OPERATION IN HERE. Doing so can affect
  /// app startup. Always do any initialization process in the splash screen's
  /// view model with a loader.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
