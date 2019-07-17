import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_icons/flutter_icons.dart';

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
      body: new Center(
        child: new FlatButton.icon(
           color: Colors.orange,
           icon: Icon(Icons.add,
           color: Colors.white,
           ),
           label: Text('Add new listing',
            style: new TextStyle(
              //fontStyle: FontStyle.italic,
              fontSize: 15.5,
              color: Colors.white,
            )),
           onPressed: () {},
        ),
      )
    );
  }
}