import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Update extends StatefulWidget {
  var idUser;
  Update({Key key, this.idUser}) : super(key: key);
  @override
  _UpdateState createState() => new _UpdateState();
}

class _UpdateState extends State<Update> {
  var _isLoading = false;
  var data;

  var _username = "";
  var _lastname = "";
  var _firstname = "";
  var _email = "";

  var _emailController = new TextEditingController();
  var _userController = new TextEditingController();
  var _firstnameController = new TextEditingController();
  var _lastnameController = new TextEditingController();


  Future<String> _ShowDialog(String msg) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Rewind and remember'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editData() async {
    var url =
        "https://blahblah.com/ModifyProfile.php";

    var response = await http.post(url, body: {
      "iduser": widget.idUser,
      "username": _userController.text,
      "firstname": _firstnameController.text,
      "lastname": _lastnameController.text,
      "email": _emailController.text,

    });
    if (response.statusCode == 200) {
      _ShowDialog("Updated Successfully");
    } else {
      _ShowDialog("Updated Failer");
    }
  }

  _fetchData() async {
    final url =
        "https://blahblah.com/ConsultProfile.php?ID=${widget.idUser}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosMap = map["result"];

      setState(() {
        _isLoading = true;
        this.data = videosMap;
        _username = data[0]['UserLogin'];
        _lastname = data[0]['LastName'];
        _firstname = data[0]['FirstName'];
        _email = data[0]['EmailAddress'];
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Update Profile"),
        ),
        body: new Center(
          child: data == null
              ? new CircularProgressIndicator()
              : new ListView(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    new Padding(
                      padding:
                      const EdgeInsets.only(top: 4.0, bottom: 25.0),
                      child: Center(
                        child: Text(
                          "Update your Profile",
                          textScaleFactor: 3.0,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("User Name : "),
                          filled: true,
                          hintText: _username),
                      controller: _userController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("First Name : "),
                          filled: true,
                          hintText: _firstname),
                      controller: _firstnameController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("Last Name : "),
                          filled: true,
                          hintText: _lastname),
                      controller: _lastnameController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: ("Gender : "),
                          filled: true,
                          hintText: _email),
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: new ButtonBar(
                        children: <Widget>[
                          new RaisedButton(
                            child: const Text(
                              'Update',
                              textScaleFactor: 2.0,
                            ),
                            onPressed: () {
                              _editData();
                            },
                          ),
                          new RaisedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.backup),
                            label: Text("Back"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}