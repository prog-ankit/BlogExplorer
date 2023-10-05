import 'package:api/Helper/SharedPrefs.dart';
import 'package:api/Model/Blogs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<Blogs> _favorite;

  List<Blogs> get favorites => _favorite;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFavorites();
  }

  void fetchFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorite = await Helper.get_blog();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_favorite.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios)),
          title: const Text(
            "Favorite Blogs",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: _favorite.length,
          itemBuilder: (context, index) => buildCard(_favorite[index]),
        ));
  }

  Widget buildCard(Blogs data) {
    return Padding(
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
                Flexible(
                  child: Text(
                    data.title.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      List<Blogs> savedBlogs = await Helper.get_blog();
                      
                      for (Blogs b in savedBlogs) {
                        if (b.id == data.id) {
                          savedBlogs.remove(b);
                          break;
                        }
                      }
                      _favorite = savedBlogs;
                      setState(() {});
                      Helper.save_blog(savedBlogs);
                      Fluttertoast.showToast(
                                msg: "Blog Removed from Favorite!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          
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
    );
    ;
  }
}
