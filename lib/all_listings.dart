import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AllListingsPage extends StatelessWidget {
  final String title;

  AllListingsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("All Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new Center(
        child: new Text("All Listings")
      )
    );
  }
}