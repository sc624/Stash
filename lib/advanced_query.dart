import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stash/globals.dart' as globals;
import 'dart:convert';
import 'dart:async';



class Advanced extends StatefulWidget {
  @override
  AdvancedState createState() => new AdvancedState();
}

class AdvancedState extends State<Advanced>{

  void nextPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Average()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Useful Information"),
        ),
      body: new ListView(
        padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0, bottom: 25.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 50,
            child: new Text(
              'Tap to view results:',
               style: TextStyle(fontWeight: FontWeight.bold),
              ),
          ),
          Container(
            height: 50,
            color: Colors.amber[200],
            child: ListTile(
              title: Center(
                child: Text('Average Price Per User'),
              ),
              onTap:(){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Average()));
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          Container(
            height: 50,
            color: Colors.amber[200],
            child: ListTile(
              title: Center(
                child: Text('Cheapest Listing By City'),
              ),
              onTap:(){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cheapest()));
              }
            ),
          ),
        ],
      ),
    );
  }
}


/*----------------User price average-------*/
class Average extends StatefulWidget {
  @override
  AverageState createState() => new AverageState();
}

class AverageState extends State<Average>{
  List data;
  
  Future<Null> _avgUser() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/userAvg.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
    );
    this.setState((){
      data = json.decode(response.body);
    });
  }

  @override
  void initState(){
    this._avgUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User Price Average"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
          child: ListTile(
            title: new Text("User: "+ data[index]["Username"]),
            subtitle: new Text("Average listing price: \$" + data[index]["PersonAVGPrice"] + " per month"),
          ),
          );
        },
      ),
    );
  }  
}


/*----------------Cheapest by zip code--------------*/
class Cheapest extends StatefulWidget {
  @override
  CheapestState createState() => new CheapestState();
}

class CheapestState extends State<Cheapest>{
  List data;

  Future<Null> _cheapZip() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/adv2.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
    );
    this.setState((){
      data = json.decode(response.body);//chinny is begging to push
    });
  }

  @override
  void initState(){
    this._cheapZip();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cheapest Price by City"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
          child:ListTile(
            title: new Text("Host Contact: " + data[index]["Email"]),
            subtitle: new Text(
              "Cheapest listing in " + data[index]["City"] + " is \$" + data[index]["ListingPrice"]
              ),
          ),
          );
        },
          
      ),
    );
  }
}