import 'dart:convert';

import 'package:api/Model/Blogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
   
  static save_blog(List<Blogs> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String encodedData = Blogs.encode(data);

    await sharedPreferences.setString('saved', encodedData);
  }

  static Future<List<Blogs>> get_blog() async{
    List<Blogs> saved;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString("saved");
    
    if(data == null || data == '') {
      saved = [];
    }else{
      saved = (json.decode(data) as List<dynamic>)
          .map<Blogs>((item) => Blogs.fromJson(item))
          .toList();
    };
    
    return saved;
  }
}