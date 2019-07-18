import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:stash/add_listing.dart';

class MyListingsPage extends StatelessWidget {
  final String title;

  MyListingsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new Container(),
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
              MaterialPageRoute(builder: (context) => AddListingPage("List Your Space")),
            );
          },
        ),
        alignment: Alignment(0.12,0.70)),
    );
  }
}