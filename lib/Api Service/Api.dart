import 'dart:convert';

import 'package:http/http.dart' as http;
class Api {
  static Future<List<dynamic>> fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    late List<dynamic> data;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        print('Response data: ${response.body}');
        final body  =response.body;
        final json = jsonDecode(body);
        data = json["blogs"] as List<dynamic>;
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        data = [];
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
      data = [];
    }
    return data;
  }
}