import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FirstNamePage extends StatefulWidget {
  @override
  FirstNameState createState() => FirstNameState();
}

class FirstNameState extends State<FirstNamePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: const Text(
              "First Name",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new TextField(
              cursorColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class LastNamePage extends StatefulWidget {
  @override
  LastNameState createState() => LastNameState();
}

class LastNameState extends State<LastNamePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: const Text(
              "Last Name",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new TextField(
              cursorColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}