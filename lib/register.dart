import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState("Register User");
}


class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RegisterScreenState(this.title);
  final String title;


  //backend call to make new user -------- password not going through IDK WHY
  void _register(){
    print('${passwordController.text}');
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/userRegister.php");
    http.post(url,
      body: {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
      }
    );
  }

  //error popup for any empty fields
  void _empty() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please make sure all fields are filled"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //non-matching password error popup
  void _wrongPassword() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Passwords do not match"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List Your Space"),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        floatingActionButton: Align(
            child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text("Register",
                  style: TextStyle(fontSize: 15.0)),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              onPressed: (){
                if(passwordController.text != confirmController.text){
                  _wrongPassword();
                }else if(usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmController.text.isEmpty || firstNameController.text.isEmpty || lastNameController.text.isEmpty){
                  _empty();
                }else{
                  _register();
                  Navigator.of(context).pop();
                }
              },
            ),
            alignment: Alignment(0.12,0.94)),
        body: new ListView(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: usernameController,
                onChanged: (v) => usernameController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hintText: 'Username',
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: firstNameController,
                onChanged: (v) => firstNameController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'First Name',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: lastNameController,
                onChanged: (v) => lastNameController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'Last Name',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: emailController,
                onChanged: (v) => emailController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: "Email Address",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: passwordController,
                onChanged: (v) => passwordController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: confirmController,
                onChanged: (v) => confirmController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'Confirm Password',
                ),
              ),
            ),
          ],
        )
    );
  }

}
