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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Welcome to ListView"),
        ),
        body:ListView.separated(
            // scrollDirection: Axis.vertical,
            itemCount: allData.length,
            separatorBuilder: (context,_) => SizedBox(width: 12),
            itemBuilder: (context,index) => buildCard(allData[index]),
          ),
        ),
      );
  }

  Widget buildCard(dynamic data) {
  return Container(
    width: 200,
    height: 200,
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
          data['title'], // Replace with the key for the title in your API data
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Image.network(
          data['image_url'],
          width: 200, // Set the width to the desired size
          height: 150, // Set the height to the desired size
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}

}


