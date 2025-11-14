import 'package:http/http.dart' as http;

class Apiclient {
  static Future<http.Response> post({
    required String url,
    required bool withAuth,
    required Map<String, dynamic> body,
  }) async {
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: withAuth
          ? {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer YOUR_TOKEN',
            }
          : {'Content-Type': 'application/json'},
    );
    return response;
  }
}
