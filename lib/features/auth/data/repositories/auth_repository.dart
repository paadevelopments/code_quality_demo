import 'package:code_quality_demo/core/data/repositories/base_repository.dart';
import 'package:code_quality_demo/features/auth/data/api/auth_api_client.dart';
import 'package:code_quality_demo/features/auth/data/models/user.dart';

/// Repository for handling authentication logic.
class AuthRepository extends BaseRepository {
  final AuthApiClient _apiClient = AuthApiClient();

  /// Logs in a user using email and password.
  Future<User> login(
    String email,
    String password, {
    Map<String, String>? additionalHeaders,
  }) {
    return execute(() => _apiClient.login(
          email,
          password,
          additionalHeaders: additionalHeaders,
        ));
  }

  /// Saves the token.
  Future<void> saveToken(String token) => _apiClient.saveAuthToken(token);

  /// Clears the token.
  Future<void> clearToken() => _apiClient.clearAuthToken();
}
