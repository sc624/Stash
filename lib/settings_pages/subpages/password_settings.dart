import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PasswordSettingsPage extends StatefulWidget {
  @override
  PasswordSettingsState createState() => PasswordSettingsState();
}

class PasswordSettingsState extends State<PasswordSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Change Password"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: const Text(
              "Current Password",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new TextField(
              obscureText: true,
              cursorColor: Colors.yellow,
            ),
          ),

        ],
      ),
    );
  }
}