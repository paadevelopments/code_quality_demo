import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for handling secure local data storage.
class StorageService {
  /// Global singleton instance.
  static final StorageService instance = StorageService._internal();
  StorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';

  /// Saves the authentication token.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieves the authentication token.
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  /// Deletes the authentication token.
  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  /// Writes a value to storage.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a value from storage.
  Future<String?> read(String key) => _storage.read(key: key);

  /// Deletes a value from storage.
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Clears all data from storage.
  Future<void> clearAll() => _storage.deleteAll();
}
