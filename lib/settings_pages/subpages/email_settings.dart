import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EmailSettingsPage extends StatefulWidget {
  @override
  EmailSettingsState createState() => EmailSettingsState();
}

class EmailSettingsState extends State<EmailSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Email"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new TextField(
              decoration: new InputDecoration(hintText: "example@email.com"),
              cursorColor: Colors.red,
              keyboardType: TextInputType.emailAddress,
            ),
          )
        ],
      ),
    );
  }
}