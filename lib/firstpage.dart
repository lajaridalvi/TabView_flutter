import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
//  class FirstPage extends StatelessWidget{
//    @override
//    Widget build( BuildContext context){
//      return new Container(
//        child :  new Center(
//          child: new Icon(Icons.accessibility_new, size:150.0 , color: Colors.red)
//        )
//      );
//    }
  
//  }

class FirstPage extends StatefulWidget{
  @override
   _FirstPage createState(){
     return _FirstPage();

   }
  }
  
  class _FirstPage extends State<FirstPage>with AutomaticKeepAliveClientMixin<FirstPage>{

    var listmovie;
    bool isLoading;
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      viewmovies();
    }
    viewmovies()async{
      // loading
      mounted ? await
      setState(() {
              isLoading = true;
            }): null;
      var output =  await http.get('https://api.themoviedb.org/3/movie/now_playing?api_key=578152be1392218f6d775ceb67b4e4f6&language=en-US&page=1');
   print(output);
  
var data = json.decode(output.body);


  // loading off
 mounted ? setState(() {
              listmovie = data['results'];
              isLoading = false;
            }): null;

  }
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      // appBar: new AppBar(title : new Text('Home')),
      body: getBody(context),
    );
  }

 Widget getBody(BuildContext context){


   if(isLoading){
     return new Center(child: new CircularProgressIndicator());
   }else {
       return new ListView.builder(
      itemCount: this.listmovie != null ? this.listmovie.length : 0,
      itemBuilder: (context, i){
        var data = this.listmovie[i];
        return new ListTile(
          leading: new CircleAvatar(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.blueGrey,
            backgroundImage: new NetworkImage('http://image.tmdb.org/t/p/w200/${data['poster_path']}'),
          ),
          title: new Text(data['title']),
          subtitle: new Text(data['release_date']),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
              builder: (context){
                return new HomeDetail(data: data);
              }
            ));
          },
        );
      },
    );
   }
  
  }

  // TODO: implement wantKeepA live
  @override
  bool get wantKeepAlive => true;
}


class HomeDetail extends StatefulWidget {

   var data;

  HomeDetail({Key key,this.data }) : super(key : key);

  @override
  _HomeDetailState createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {

 

  _HomeDetailState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.data['title']),),
      body :  Container(
      child: new Column(
        children: <Widget>[
          new Container(
            // margin: const EdgeInsets.only(bottom: 30.0),
            height: 200.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage('http://image.tmdb.org/t/p/w200/${widget.data['backdrop_path']}' )
              )
            ),
          ),
          
          new Text(widget.data['title'],textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold )),
          
          // new Text(widget.data['original_language']),
          new Text(widget.data['overview'],textAlign: TextAlign.start,style: new TextStyle(fontStyle: FontStyle.italic))



        ],
      )
         
      ),
    );
    
  }
}