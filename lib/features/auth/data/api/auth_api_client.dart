import 'package:code_quality_demo/core/data/api/base_api_client.dart';
import 'package:code_quality_demo/features/auth/data/models/user.dart';

/// Handles authentication API requests.
class AuthApiClient extends BaseApiClient {
  /// Mocks a login request by fetching a specific user.
  Future<User> login(
    String email,
    String password, {
    Map<String, String>? additionalHeaders,
  }) async {
    final response = await get(
      '/users/1',
      additionalHeaders: additionalHeaders,
    );
    return User.fromJson(response);
  }
}
