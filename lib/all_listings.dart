import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:stash/all_listings.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllListingsPage extends StatefulWidget {
  @override
  _AllListingsPage createState() => _AllListingsPage("All Listings");
}
  

class _AllListingsPage extends State<AllListingsPage> {
  _AllListingsPage(this.title);
  final String title;
  TextEditingController searchController = TextEditingController();

  List data1;

  //finds all listing prices less than given
  Future<String> _findData() async {
    var response = await http.post(
      Uri.encodeFull("https://mysterymachine.web.illinois.edu/priceFilter.php"),
      headers: {
        "Accept": "application/json"
      },
      body: {
        "listingprice": searchController.text,
      }
    );

    this.setState((){
      data1 = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState(){
    this._findData();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("All Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      floatingActionButton: Align(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.search),
          label: Text("Search",
          style: TextStyle(fontSize: 14.0)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            _findData();
          },
        ),
        alignment: Alignment(0.12,0.45)),
      body: new ListView(
      children: <Widget> [
         Padding(
            padding: const EdgeInsets.only(left: 17.5, top: 180.0),
            child: const Text(
              "Find listings with prices less than: ",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ), 
         Padding(
         padding: const EdgeInsets.all(15.0),
         child: TextField(
           controller: searchController,
           onChanged: (v) => searchController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.deepOrange,
             hintText: 'e.g. 20',
          ), 
         ),
         ),
         new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data1 == null ? 0 : data1.length,
          itemBuilder: (BuildContext context, int index){
            return new ListTile(
              title: new Text(data1[index]["ListingType"]),
            );
        },
      ),
      ],
      ),
    );

  }
}