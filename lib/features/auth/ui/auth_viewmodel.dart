import 'package:code_quality_demo/core/data/services/storage_service.dart';
import 'package:code_quality_demo/core/ui/base_viewmodel.dart';
import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:code_quality_demo/features/auth/data/models/user.dart';
import 'package:code_quality_demo/features/auth/data/repositories/auth_repository.dart';

/// Manages authentication state and logic globally.
class AuthViewModel extends BaseViewModel {
  /// Global singleton instance.
  static final AuthViewModel instance = AuthViewModel._internal();
  AuthViewModel._internal();

  final AuthRepository _repository = AuthRepository();
  final StorageService _storage = StorageService.instance;

  User? _currentUser;

  /// Gets the currently logged-in user.
  User? get currentUser => _currentUser;

  /// Checks if a user is authenticated.
  bool get isAuthenticated => _currentUser != null;

  /// Initializes the authentication state.
  Future<void> init() async {
    final token = await _storage.getToken();
    if (token != null) {
      // In a real app, you might validate the token or fetch user profile.
      // We mock a logged in user if a token exists.
      _currentUser =
          User(id: '1', email: 'saved@example.com', name: 'Saved User');
      refresh();
    }
  }

  /// Authenticates a user and redirects to home.
  Future<void> login(
    String email,
    String password, {
    Map<String, String>? additionalHeaders,
  }) async {
    setLoading();
    try {
      _currentUser = await _repository.login(
        email,
        password,
        additionalHeaders: additionalHeaders,
      );
      await _repository.saveToken('mock_token_${_currentUser?.id}');
      setSuccess(_currentUser);
      goHome(AppRoutes.posts);
    } catch (e) {
      setError(e.toString());
    }
    refresh();
  }

  /// Logs out the current user and redirects to login screen.
  Future<void> logout() async {
    _currentUser = null;
    await _repository.clearToken();
    setIdle();
    goHome(AppRoutes.login);
    refresh();
  }
}
