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
          title: Text("Hello Welcome to ListView"),
        ),
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
  return Container(
    width: 200,
    height: 200,
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: Colors.green, // Background color
      border: Border.all(
        color: Colors.blue, // Border color
        width: 2.0,         // Border width
      ),
    ),
    child: Column(
      children: [
        Text(
          data.title.toString(), // Replace with the key for the title in your API data
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Image.network(
          data.image.toString(),
          width: 200, // Set the width to the desired size
          height: 150, // Set the height to the desired size
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}

}


