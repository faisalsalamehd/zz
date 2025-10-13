import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zz/utils/storage_manager.dart';
import 'package:zz/utils/storage_service.dart';
import 'package:zz/main.dart' show navigatorKey;
import 'package:zz/routes/routes_strings.dart';

/// Custom exception classes for better error handling
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException({required super.message}) : super(statusCode: null);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String? message})
    : super(message: message ?? 'Unauthorized access', statusCode: 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException({String? message})
    : super(message: message ?? 'Access forbidden', statusCode: 403);
}

class NotFoundException extends ApiException {
  NotFoundException({String? message})
    : super(message: message ?? 'Resource not found', statusCode: 404);
}

class ServerException extends ApiException {
  ServerException({String? message})
    : super(message: message ?? 'Server error occurred', statusCode: 500);
}

class TimeoutException extends ApiException {
  TimeoutException({String? message})
    : super(message: message ?? 'Request timeout', statusCode: 408);
}

/// Main API Client class with improved error handling
class ApiClient {
  // Default timeout duration
  static const Duration _defaultTimeout = Duration(seconds: 30);

  /// Private constructor to prevent instantiation
  ApiClient._();

  /// Build headers for requests
  static Map<String, String> _buildHeaders({
    required bool withAuth,
    Map<String, String>? additionalHeaders,
  }) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth) {
      final token = StorageService().getAuthToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// POST request with improved error handling
  static Future<http.Response> post(
    String url,
    bool withAuth,
    Map<String, dynamic> body, {
    Duration? timeout,
    Map<String, String>? additionalHeaders,
    bool showErrorSnackbar = true,
  }) async {
    try {
      final headers = _buildHeaders(
        withAuth: withAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .timeout(timeout ?? _defaultTimeout);

      return _handleResponse(response, showErrorSnackbar: showErrorSnackbar);
    } on SocketException {
      throw NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please try again.',
        statusCode: 408,
      );
    } on FormatException {
      throw ApiException(message: 'Invalid data format received from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// PUT request with improved error handling
  static Future<http.Response> put(
    String url,
    bool withAuth,
    Map<String, dynamic> body, {
    Duration? timeout,
    Map<String, String>? additionalHeaders,
    bool showErrorSnackbar = true,
  }) async {
    try {
      final headers = _buildHeaders(
        withAuth: withAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .timeout(timeout ?? _defaultTimeout);

      return _handleResponse(response, showErrorSnackbar: showErrorSnackbar);
    } on SocketException {
      throw NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please try again.',
        statusCode: 408,
      );
    } on FormatException {
      throw ApiException(message: 'Invalid data format received from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// GET request with improved error handling
  static Future<http.Response> get(
    String url,
    bool withAuth, {
    Duration? timeout,
    Map<String, String>? additionalHeaders,
    bool showErrorSnackbar = true,
  }) async {
    try {
      final headers = _buildHeaders(
        withAuth: withAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(timeout ?? _defaultTimeout);

      return _handleResponse(response, showErrorSnackbar: showErrorSnackbar);
    } on SocketException {
      throw NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please try again.',
        statusCode: 408,
      );
    } on FormatException {
      throw ApiException(message: 'Invalid data format received from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// DELETE request
  static Future<http.Response> delete(
    String url,
    bool withAuth, {
    Duration? timeout,
    Map<String, String>? additionalHeaders,
    bool showErrorSnackbar = true,
  }) async {
    try {
      final headers = _buildHeaders(
        withAuth: withAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(timeout ?? _defaultTimeout);

      return _handleResponse(response, showErrorSnackbar: showErrorSnackbar);
    } on SocketException {
      throw NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please try again.',
        statusCode: 408,
      );
    } on FormatException {
      throw ApiException(message: 'Invalid data format received from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// PATCH request
  static Future<http.Response> patch(
    String url,
    bool withAuth,
    Map<String, dynamic> body, {
    Duration? timeout,
    Map<String, String>? additionalHeaders,
    bool showErrorSnackbar = true,
  }) async {
    try {
      final headers = _buildHeaders(
        withAuth: withAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http
          .patch(Uri.parse(url), headers: headers, body: json.encode(body))
          .timeout(timeout ?? _defaultTimeout);

      return _handleResponse(response, showErrorSnackbar: showErrorSnackbar);
    } on SocketException {
      throw NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ApiException(
        message: 'Request timeout. Please try again.',
        statusCode: 408,
      );
    } on FormatException {
      throw ApiException(message: 'Invalid data format received from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// Handle response and check for errors
  static http.Response _handleResponse(
    http.Response response, {
    bool showErrorSnackbar = true,
  }) {
    // Success responses (200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    // Parse error message from response body
    String errorMessage = _parseErrorMessage(response);

    // Handle specific error codes
    switch (response.statusCode) {
      case 401:
        _handleUnauthorized();
        throw UnauthorizedException(message: errorMessage);

      case 403:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Access Denied', errorMessage);
        }
        throw ForbiddenException(message: errorMessage);

      case 404:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Not Found', errorMessage);
        }
        throw NotFoundException(message: errorMessage);

      case 408:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Timeout', errorMessage);
        }
        throw TimeoutException(message: errorMessage);

      case 422:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Validation Error', errorMessage);
        }
        throw ApiException(
          message: errorMessage,
          statusCode: 422,
          data: _parseResponseBody(response),
        );

      case 500:
      case 502:
      case 503:
      case 504:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Server Error', errorMessage);
        }
        throw ServerException(message: errorMessage);

      default:
        if (showErrorSnackbar) {
          _showErrorSnackbar('Error ${response.statusCode}', errorMessage);
        }
        throw ApiException(
          message: errorMessage,
          statusCode: response.statusCode,
          data: _parseResponseBody(response),
        );
    }
  }

  /// Parse error message from response
  static String _parseErrorMessage(http.Response response) {
    try {
      final data = json.decode(response.body);

      // Try different common error message fields
      if (data is Map<String, dynamic>) {
        if (data['message'] != null) return data['message'].toString();
        if (data['error'] != null) {
          if (data['error'] is String) return data['error'];
          if (data['error'] is Map && data['error']['message'] != null) {
            return data['error']['message'].toString();
          }
        }
        if (data['errors'] != null) {
          if (data['errors'] is String) return data['errors'];
          if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
            return (data['errors'] as List).first.toString();
          }
        }
      }

      return response.body;
    } catch (e) {
      return response.body.isNotEmpty
          ? response.body
          : 'An error occurred (Status: ${response.statusCode})';
    }
  }

  /// Parse response body safely
  static dynamic _parseResponseBody(http.Response response) {
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Handle unauthorized access (401)
  static void _handleUnauthorized() {
    // Clear stored tokens
    StorageManager().logoutUser();
    
    // Show error message
    _showErrorSnackbar(
      'Session Expired',
      'Your session has expired. Please login again.',
    );
    
    // Navigate to login screen after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RoutesStrings.login,
          (route) => false, // Remove all previous routes
        );
      }
    });
  }

  /// Show error snackbar
  static void _showErrorSnackbar(String title, String message) {
    // Get the current context from the global navigator key
    final context = navigatorKey.currentContext;
    
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(message),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = StorageService().getAuthToken();
    return token != null && token.isNotEmpty;
  }
}
