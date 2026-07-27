import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

/// Screen shown when a requested route is not defined.
class NotFoundScreen extends StatelessWidget {
  /// The name of the missing route.
  final String? routeName;

  /// Creates a not found screen.
  const NotFoundScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText('No route defined for $routeName'),
      ),
    );
  }
}
