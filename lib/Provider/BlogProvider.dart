import 'package:api/Api%20Service/Api.dart';
import 'package:api/Model/Blogs.dart';
import 'package:flutter/material.dart';

class BlogProvider extends ChangeNotifier {
  List<Blogs> _blogs = [];
  
  List<Blogs> get blogs => _blogs;
  Future<void> getAllBlogs() async {
    final response = await Api.fetchBlogs();
    _blogs = response;
    notifyListeners();
  }
}