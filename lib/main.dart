import 'package:flutter/material.dart';
import './firstpage.dart'as first;
import './secondpage.dart' as second;
import './thirdpage.dart' as third;
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Hello All",
      home: new MyTab(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyTab extends StatefulWidget{
  @override 
    MyTabState  createState() => new MyTabState();
  }
  class MyTabState extends State<MyTab>with SingleTickerProviderStateMixin{
    TabController controller;

    @override
    void initState(){
      super.initState();
      controller = new  TabController(vsync: this,length:3);
          }
          @override
          void dispose(){
            controller.dispose();
            super.dispose();
          }
    @override

    Widget build(BuildContext context){
      return new Scaffold(
        appBar: new AppBar(title: new Text("TabView"),
        backgroundColor: Colors.blue,
          bottom: new TabBar(
            controller: controller,
            tabs:<Tab>[
              new Tab(icon: new Icon(Icons.movie)),
              new Tab(icon: new Icon(Icons.contacts)),
              new Tab(icon: new Icon(Icons.group_work)),

            ]
          ),
        
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first.FirstPage(),
            new second.SecondPage(),
            new third.ThirdPage()
          ],

        ),

      );
    }
  }

  