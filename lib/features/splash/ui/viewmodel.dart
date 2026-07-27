import 'package:code_quality_demo/core/ui/base_viewmodel.dart';
import 'package:code_quality_demo/core/ui/localization/localization_viewmodel.dart';
import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:code_quality_demo/core/ui/theme/theme_viewmodel.dart';
import 'package:code_quality_demo/features/auth/ui/auth_viewmodel.dart';

/// ViewModel for managing application initialization.
class SplashViewModel extends BaseViewModel {
  /// Initializes core services and navigates to the starting screen.
  Future<void> initializeApp() async {
    setLoading();
    try {
      await ThemeViewModel.instance.init();
      await LocalizationViewModel.instance.init();
      await AuthViewModel.instance.init();
      
      final nextRoute = AuthViewModel.instance.isAuthenticated
          ? AppRoutes.posts
          : AppRoutes.login;
          
      goHome(nextRoute);
    } catch (e) {
      setError(e.toString());
    }
  }
}
