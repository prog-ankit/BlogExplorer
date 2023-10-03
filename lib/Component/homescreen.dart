import 'package:api/Api%20Service/Api.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    fetchData();
  }
  fetchData() async{
    allData = await Api.fetchBlogs();
    setState(() { });
    print(allData);
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
