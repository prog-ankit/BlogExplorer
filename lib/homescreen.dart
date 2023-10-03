import 'package:api/Api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  void initState() {
    // TODO: implement initState
    Api.fetchBlogs();
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
