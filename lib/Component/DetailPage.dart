import 'package:api/Model/Blogs.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  Blogs blog;
  DetailPage({super.key, required this.blog});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subspace', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: [
              Image.network(blog.image!),
              const SizedBox(height: 10.0,),
              Text(
                blog.id!,
                style: const TextStyle(
                  fontFamily: "Verdana",
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                blog.title!,
                style: const TextStyle(
                  fontFamily: "Verdana",
                  color: Colors.white,
                ),
              ),

          ],
        ),
      ),
    );
  }
}
