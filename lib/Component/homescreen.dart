import 'package:api/Component/DetailPage.dart';
import 'package:api/Component/Favorites.dart';
import 'package:api/Helper/SharedPrefs.dart';
import 'package:api/Model/Blogs.dart';
import 'package:api/Provider/BlogProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      style: const TextStyle(
          fontSize: 15, color: Colors.white, backgroundColor: Colors.black),
    ));
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
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
    // print("testing");
    // print(data.image.toString());
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
          child: Column(children: [
            Image.network(
              data.image.toString(),
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Container(
              // width: MediaQuery.of(context).size.width*0.8,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // RichText(text: TextSpan(text: data.title.toString())),
                  Flexible(
                    child: Text(
                      data.title.toString(),
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),

                  IconButton(
                      onPressed: () async {
                        // print(data.image.toString());
                        List<Blogs> savedBlogs = await Helper.get_blog();
                        bool noadd = false;
                        for (Blogs b in savedBlogs) {
                          if (b.id == data.id) {
                            noadd = true;
                            
                            Fluttertoast.showToast(
                                msg: "Blog Already Exists!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        }
                        if (!noadd) {
                          savedBlogs.add(data);
                          //   print(data);
                          // print(savedBlogs.toString());
                          Helper.save_blog(savedBlogs);
                          Fluttertoast.showToast(
                                msg: "Blog Added to Favorite!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          
                        }
                      },
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
