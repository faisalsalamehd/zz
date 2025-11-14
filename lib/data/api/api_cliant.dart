import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static Future<http.Response> post({
    required String url,
    required bool withAuth,
    required Map<String, dynamic> body,
  }) async {
    http.Response response = http.Response('', 400);
    try {
       response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: withAuth
            ? {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer YOUR_AUTH_TOKEN',
              }
            : {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {}

    return response;
  }
}
