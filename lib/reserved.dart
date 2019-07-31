import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stash/globals.dart' as globals;
import 'package:stash/all_listings.dart';
import 'dart:convert';
import 'dart:async';



class BookingPage extends StatefulWidget {
  @override
  BookingPageState createState() => new BookingPageState();
}

class BookingPageState extends State<BookingPage>{
  List data;
  int pls;

  // flutter defined function
  void _cancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Deletion"),
          content: new Text("Are you sure you want to cancel your booking?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Confirm"),
              onPressed: () {
                _remove();
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
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _remove(){
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/cancelBooking.php");

    http.post(url, body: {
      "listingid": globals.lID,
    });
  }

  //get bookings list
  Future<Null> getData() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/myBookedListings.php");
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

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My booked listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          new ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onDoubleTap:(){
                  globals.lID = data[index]["ListingID"];
//                  pls = index;
                  _cancel();
                  pls = index;
                },
                child: new Card(
                  //custom list tile
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
                    author: data[index]["Username"],
                    publishDate: data[index]["Email"],
                    readDuration: data[index]["ListingPrice"],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}