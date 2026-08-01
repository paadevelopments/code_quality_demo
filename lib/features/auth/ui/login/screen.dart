import 'package:code_quality_demo/core/ui/navigation/app_navigator.dart';
import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:code_quality_demo/features/auth/ui/auth_viewmodel.dart';
import 'package:code_quality_demo/features/auth/ui/login/widgets/login_form.dart';
import 'package:flutter/material.dart';

/// The screen where users log into the application.
class LoginScreen extends StatefulWidget {
  /// Creates the login screen.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    AuthViewModel.instance.navigationRequest.addListener(_onNavigationRequest);
  }

  void _onNavigationRequest() {
    final request = AuthViewModel.instance.navigationRequest.value;
    if (request == null || !mounted) {
      return;
    }

    if (request.isAndRemoveUntil && request.routeName != null) {
      AppNavigator.pushAndRemoveUntil(
        request.routeName!,
        arguments: request.arguments,
      );
    } else if (!request.isPop && request.routeName != null) {
      AppNavigator.push(request.routeName!, arguments: request.arguments);
    }
  }

  @override
  void dispose() {
    AuthViewModel.instance.navigationRequest
        .removeListener(_onNavigationRequest);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Login')),
      body: const LoginForm(),
    );
  }
}
