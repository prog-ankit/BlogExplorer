import 'package:api/Component/DetailPage.dart';
import 'package:api/Model/Blogs.dart';
import 'package:api/Provider/BlogProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> allData;
  @override
  void initState() {
    super.initState();
    Provider.of<BlogProvider>(context, listen: false).getAllBlogs();
  }
  
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Blogs and Articles", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromARGB(221, 17, 17, 17),
        body:Consumer<BlogProvider>(
          builder: (context, value, child) {
            final blogs = value.blogs;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context,index) => buildCard(blogs[index]),
            );
          }
        ),
        ),
      );
  }

  Widget buildCard(Blogs data) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return DetailPage(blog: data);
      },));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: const BoxDecoration(
        color: Colors.black87, // Background color
      ),
      child: Column(
        children: [
          Image.network(
            data.image.toString(),
            fit: BoxFit.fill,
          ),
          Text(
            data.title.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

}


