import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:stash/add_listing.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash/edit_listing.dart';
import 'package:stash/globals.dart' as globals;

class MyListingsPage extends StatefulWidget {
   @override 
   MyListingsPageState createState() => new MyListingsPageState();
}

class MyListingsPageState extends State<MyListingsPage> {
  //MyListingsPageState(this.title);

  //final String title;

  List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://mysterymachine.web.illinois.edu/allListings.php"),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState((){

    data = json.decode(response.body);
    //print(data.toString());

    });

    print(data[1]["ListingType"]);
    
    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  void _deleteData() {
    var url = "https://mysterymachine.web.illinois.edu/deleteListing.php";

    http.post(url, body: {
       "listingid": globals.lID,
    });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
            return new ListTile(

            title: new Text(data[index]["ListingID"]),
            onLongPress: () {
              setState(() {
                globals.lID = data[index]["ListingID"];
                print(globals.lID);
                _deleteData();
              });
            },
            onTap: (){
              Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => EditListingPage()),
              );
              print("Item at $index is ${data[index]["ListingID"]}");
             globals.lID = data[index]["ListingID"];
              print(globals.lID);
            }
            );
        },
      ),
      


      floatingActionButton: Align(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Listing",
          style: TextStyle(fontSize: 14.5)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddListingPage()),
            );
          },
        ),
        alignment: Alignment(0.12,0.70)),
    );
  }
}