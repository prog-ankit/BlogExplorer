import 'dart:convert';

import 'package:api/Model/Blogs.dart';
import 'package:http/http.dart' as http;
class Api {
  static Future<List<Blogs>> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
  //  late List<dynamic> data;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
       // print('Response data: ${response.body}');
        final body  =response.body;
        final json = jsonDecode(body)["blogs"] as List;
     //   print(json);
        final blogs = json.map(
          (b){
            return Blogs(
              id: b['id'],
              title: b['title'],
              image: b['image_url'] 
            );
          }
        ).toList();
        return blogs;
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        return [];
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
     return [];
    }

  }
}