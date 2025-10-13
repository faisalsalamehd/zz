import 'dart:convert';
import 'package:zz/data/api/api_client.dart';
import 'package:zz/data/api/api_string.dart';
import 'package:zz/data/models/login_request.dart';
import 'package:zz/data/models/login_response.dart';
import 'package:zz/utils/storage_manager.dart';

/// Login Repository
/// Handles all login-related API calls with clean architecture
class LoginRepo {
  // Singleton pattern
  static final LoginRepo _instance = LoginRepo._internal();
  factory LoginRepo() => _instance;
  LoginRepo._internal();

  final StorageManager _storage = StorageManager();


  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        username: username,
        password: password,
      );

      final response = await ApiClient.post(
        ApiString.getUrl(ApiString.login),
        false, // No auth required for login
        request.toJson(),
        showErrorSnackbar: true,
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final loginResponse = LoginResponse.fromJson(responseData);

      // Save tokens and user data to storage
      await _saveUserSession(loginResponse);

      return loginResponse;
    } catch (e) {
      // Re-throw to let the UI handle it
      rethrow;
    }
  }

  /// Save user session data to local storage
  Future<void> _saveUserSession(LoginResponse loginResponse) async {
    // Use StorageManager's loginUser method
    await _storage.loginUser(
      token: loginResponse.accessToken,
      userData: {
        'id': loginResponse.id,
        'username': loginResponse.username,
        'email': loginResponse.email,
        'firstName': loginResponse.firstName,
        'lastName': loginResponse.lastName,
        'gender': loginResponse.gender,
        'image': loginResponse.image,
      },
    );

    // Save refresh token separately
    await _storage.updateSetting('refresh_token', loginResponse.refreshToken);

    print('✅ User session saved successfully');
  }

  /// Check if user is already logged in
  Future<bool> isLoggedIn() async {
    return _storage.isAuthenticated();
  }

  /// Get current user profile from storage
  Map<String, dynamic>? getCurrentUser() {
    return _storage.getUserProfile();
  }

  /// Logout user
  Future<void> logout() async {
    await _storage.logoutUser();
    print('✅ User logged out successfully');
  }

  /// Refresh access token (if needed in future)
  Future<String?> refreshAccessToken() async {
    try {
      final refreshToken = _storage.getSetting('refresh_token');
      
      if (refreshToken == null) {
        throw ApiException(message: 'No refresh token available');
      }

      // Implement refresh token logic if API supports it
      // For now, just return null
      return null;
    } catch (e) {
      print('❌ Failed to refresh token: $e');
      return null;
    }
  }
}
