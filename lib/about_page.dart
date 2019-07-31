import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new ListTile(
              title: new Text(
                "What are we?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text(
                  mission_statement
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0) ,
             child: new ListTile(
                title: new Text(
                  "Instruction Taps",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                    "single tap to RESERVE a listing, double tap to DELETE a listing",
                  ),
                  ),
             ),
            ),
        ]
      )
    );
  }
}

String mission_statement = """At Stash, our mission is to connect people with unused storage space to people seeking storage space. """;