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
          content: new Text("Are you sure you want to delete your listing?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
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
              child: new Text("No"),
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
  Future<String> getData() async {
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

    return "Success!";
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
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child:ListTile(
                title: new Text(data[index]["ListingType"]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    globals.lID = data[index]["ListingID"];
                    pls = index;
                    _cancel();
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditListingPage()),
                  );
                  globals.lID = data[index]["ListingID"];
                }            
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
