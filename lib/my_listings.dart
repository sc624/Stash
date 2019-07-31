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
  bool flag;
  int pls;

//alert dialog
  bool _cancel() {
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
              child: new Text("Confirm"),
              onPressed: () {
                _deleteData();
                print('${globals.lID}');
                setState(() {
                  data.removeAt(pls);
                });
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                setState(() {
                  flag = false;
                });
               Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return flag;
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
            onTap: () {
              globals.lID = data[index]["ListingID"];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditListingPage()),
              );
            },
            onDoubleTap: () {
                 globals.lID = data[index]["ListingID"];
                 _cancel();
                 pls = index;
                //  data.removeAt(index);
            },
            child: new Card(
                child:CustomListItemTwo(
                  thumbnail: Container(
                    decoration: const BoxDecoration(color: Colors.orange),
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
            label: Text("New Listing",
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

