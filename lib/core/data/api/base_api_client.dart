import 'dart:convert';

import 'package:code_quality_demo/core/data/services/storage_service.dart';
import 'package:http/http.dart' as http;

/// Handles low-level HTTP communication with auth token management.
class BaseApiClient {
  /// The base URL for the API.
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  final StorageService _storage = StorageService.instance;

  /// Performs a GET request.
  Future<dynamic> get(
    String path, {
    bool isProtected = false,
    Map<String, String>? additionalHeaders,
  }) async {
    final headers = await _getHeaders(isProtected, additionalHeaders);
    final response =
        await http.get(Uri.parse('$baseUrl$path'), headers: headers);
    return _handleResponse(response);
  }

  /// Performs a POST request.
  Future<dynamic> post(
    String path, {
    dynamic body,
    bool isProtected = false,
    Map<String, String>? additionalHeaders,
  }) async {
    final headers = await _getHeaders(isProtected, additionalHeaders);
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _getHeaders(
    bool isProtected,
    Map<String, String>? additionalHeaders,
  ) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (isProtected) {
      final token = await _storage.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }

  /// Saves the authentication token.
  Future<void> saveAuthToken(String token) async {
    await _storage.saveToken(token);
  }

  /// Clears the authentication token.
  Future<void> clearAuthToken() async {
    await _storage.deleteToken();
  }
}
