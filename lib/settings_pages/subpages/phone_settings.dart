import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class PhoneSettingsPage extends StatefulWidget {
  @override
  PhoneSettingsState createState() => PhoneSettingsState();
}

class PhoneSettingsState extends State<PhoneSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Phone"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: const Text(
              "Phone Number",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new TextField(
              decoration: new InputDecoration(hintText: "1234567890"),
              cursorColor: Colors.red,
              maxLength: 10, ////// CHANGE AFTER ADDING INTERNATIONAL NUMBERS SUPPORT
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                ////// ADD tel_input PACKAGE FOR INTERNATIONAL PHONE NUMBERS OR CUSTOM PHONE NUMBER FORMATS
              ],
              keyboardType: TextInputType.phone,
            ),
          )
        ],
      ),
    );
  }
}