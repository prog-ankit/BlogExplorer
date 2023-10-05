import 'package:api/Component/DetailPage.dart';
import 'package:api/Component/Favorites.dart';
import 'package:api/Helper/SharedPrefs.dart';
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
          title: const Text(
            "Blogs and Articles",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => Favorites(),
                    )),
                icon: Icon(Icons.favorite))
          ],
        ),
        backgroundColor: const Color.fromARGB(221, 17, 17, 17),
        body: Consumer<BlogProvider>(builder: (context, value, child) {
          final blogs = value.blogs;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) => buildCard(blogs[index]),
          );
        }),
      ),
    );
  }

  Widget buildCard(Blogs data) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetailPage(blog: data);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.title.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () async {
                        List<Blogs> savedBlogs = await Helper.get_blog();
                        bool noadd = false;
                        for (Blogs b in savedBlogs) {
                          if (b.id == data.id) {
                            noadd = true;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Already Exists in Favorite',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ));
                          }
                        }
                        if (!noadd) {
                          savedBlogs.add(data);
                          Helper.save_blog(savedBlogs);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('A SnackBar has been shown.'),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
