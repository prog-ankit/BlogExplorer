import 'dart:convert';

class Blogs {
  String? id;
  String? title;
  String? image;

  Blogs({this.id,this.title,this.image});
   factory Blogs.fromJson(Map<String, dynamic> jsonData) {
    return Blogs(
      id: jsonData['id'],
     title:  jsonData['title'],
     image: jsonData['image_url']
    );
  }

  static Map<String, dynamic> toMap(Blogs blogs) => {
        'id':  blogs.id,
        'title' : blogs.title,
        'image' : blogs.image
      };

  static String encode(List<Blogs> blogs) => json.encode(
        blogs
            .map<Map<String, dynamic>>((b) => Blogs.toMap(b))
            .toList(),
      );

  static List<Blogs> decode(String Blogss) =>
      (json.decode(Blogss) as List<dynamic>)
          .map<Blogs>((item) => Blogs.fromJson(item))
          .toList();
}