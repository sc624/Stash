import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class MyListingsPage extends StatelessWidget {
  final String title;

  MyListingsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("These are my listings"),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
    );
  }
}