import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MyListingsSettingsPage extends StatelessWidget {
  final String title;

  MyListingsSettingsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new Center(
        child: new Text("Listings")
      )
    );
  }
}