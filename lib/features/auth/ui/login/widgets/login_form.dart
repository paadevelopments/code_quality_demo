import 'package:code_quality_demo/core/domain/extensions/validation_extensions.dart';
import 'package:code_quality_demo/core/domain/models/ui_state.dart';
import 'package:code_quality_demo/core/resources/images/app_images.dart';
import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:code_quality_demo/features/auth/ui/auth_viewmodel.dart';
import 'package:flutter/material.dart';

/// The form containing login inputs and action button.
class LoginForm extends StatefulWidget {
  /// Creates the login form.
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authViewModel = AuthViewModel.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _authViewModel.login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(AppImages.logo, height: 100),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: AppStrings.email),
              validator: (value) => value.validateEmail(),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: AppStrings.password),
              obscureText: true,
              validator: (value) => value.validatePassword(),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<UiState>(
              valueListenable: _authViewModel.uiState,
              builder: (context, state, _) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: _handleLogin,
                  child: const AppText(AppStrings.login),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
