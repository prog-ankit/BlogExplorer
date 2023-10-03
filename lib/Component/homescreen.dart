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
        body: Container(
          height: 250,
          child:SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
                buildCard(),
                SizedBox(width: 20),
              ],
            ),
          )
        ),
      ),

    );

  }

  Widget buildCard() {
    return Container(
        width: 200,
      height: 200,
      color: Colors.red,
      child: Column(
      children : [
        Image.network(
          'https://t4.ftcdn.net/jpg/05/47/97/81/360_F_547978128_vqEEUYBr1vcAwfRAqReZXTYtyawpgLcC.jpg'
        ),
        const SizedBox(height: 4),
        Text('SingleChildScrollView is especially useful for creating forms,',
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)
          ,)
      ]
    )
    );
  }


}


