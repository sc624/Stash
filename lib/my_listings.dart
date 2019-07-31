import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:stash/add_listing.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash/edit_listing.dart';
import 'package:stash/globals.dart' as globals;
import 'package:stash/all_listings.dart';


class MyListingsPage extends StatefulWidget {
  @override
  MyListingsPageState createState() => new MyListingsPageState();
}

class MyListingsPageState extends State<MyListingsPage> {
  //MyListingsPageState(this.title);
  //final String title;
  List data;
  List data1;
  int pls;

//alert dialog
  void _cancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Deletion"),
          content: new Text("Are you sure you want to delete this listing?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                _deleteData();
                setState(() {
                  data.removeAt(pls);
                });
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                setState(() {
                });
               Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //advanced function
  Future<Null> printData() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/printData.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
      body: {
        "userid": globals.userID,
      },
    );

    this.setState((){
      data1 = json.decode(response.body);
    });
  }

  //back end call to get all listings
  Future<Null> getData() async {
//    print('${globals.userID}');
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/myListings.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
      body: {
        "userid": globals.userID,
      },
    );

    this.setState((){
      data = json.decode(response.body);
    });
  }




  @override
  void initState(){
    this.getData();
  }

//backend call to delete listing
  void _deleteData() {
    var url = "https://mysterymachine.web.illinois.edu/deleteListing.php";

    http.post(url, body: {
      "listingid": globals.lID,
    });
  }


//body
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onLongPress: () {
              globals.lID = data[index]["ListingID"];
              printData();
              Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new EditListingPage()),)
                  .then((val)=> val ? getData() : null);
            },
            onDoubleTap: () {
                 globals.lID = data[index]["ListingID"];
                 _cancel();
                 pls = index;
            },
            child: new Card(
              child:CustomListItemTwo(
                thumbnail: Icon(
                  Icons.home,
                  size: 90.0,
                  color: Colors.orange,
                ),
                title: data[index]["ListingType"],
                subtitle: data[index]["StreetName"],
                subtitle2: data[index]["City"],
                subtitle3: data[index]["State"],
                author: globals.username,
                publishDate: globals.useremail,
                readDuration: data[index]["ListingPrice"],
              ),
            ),
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
          Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new AddListingPage()),)
              .then((val)=> val ? getData() : null);
          },
        ),
      alignment: Alignment(0.12,0.70)),
    );
  }
}

