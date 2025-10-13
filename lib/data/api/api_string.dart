class ApiString {
  static const String baseUrl = 'https://dummyjson.com';
  static const String login = '/user/login';
  
  /// Get full URL for an endpoint
  static String getUrl(String endpoint) => '$baseUrl$endpoint';
}
