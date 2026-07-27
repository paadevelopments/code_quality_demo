import 'package:code_quality_demo/core/ui/navigation/app_navigator.dart';
import 'package:code_quality_demo/features/splash/ui/viewmodel.dart';
import 'package:flutter/material.dart';

/// Initial screen shown while the app is loading.
class SplashScreen extends StatefulWidget {
  /// Creates a splash screen.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _viewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.initializeApp();
    _viewModel.navigationRequest.addListener(_onNavigationRequest);
  }

  void _onNavigationRequest() {
    final request = _viewModel.navigationRequest.value;
    if (request == null) {
      return;
    }

    if (request.isAndRemoveUntil && request.routeName != null) {
      AppNavigator.goHome();
    }
  }

  @override
  void dispose() {
    _viewModel.navigationRequest.removeListener(_onNavigationRequest);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
