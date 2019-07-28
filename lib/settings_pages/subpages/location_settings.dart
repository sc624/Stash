import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LocationSettingsPage extends StatelessWidget {
  final String title;

  LocationSettingsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Location Settings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new Center(
        child: new Text("Location Settings Page")
      )
    );
  }
}