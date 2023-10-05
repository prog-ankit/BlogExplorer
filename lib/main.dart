import 'package:api/Provider/BlogProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Component/homescreen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => BlogProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    ),);
  }
}

