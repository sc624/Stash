import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return new MaterialApp(
      home: new LoginScreen(),
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.white : null
      )
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{

  AnimationController iconAnimationController;
  Animation<double> iconAnimation;

  @override
  void initState(){
    super.initState();
    iconAnimationController = new AnimationController(
        vsync: this,
      duration: new Duration(milliseconds: 500)
    );
    iconAnimation = new CurvedAnimation(
        parent: iconAnimationController,
        curve: Curves.easeOut
    );
    iconAnimation.addListener(()=> this.setState((){}));
    iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.orange,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/login-logo-stash.png"),
                width: 200.0,
                height: 100.0,
              ),
              new Form(
                  child: new Theme(
                    data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.orange,
                      inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        )
                      )
                    ),
                    child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter Your Email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                          ),
                          new MaterialButton(
                              elevation: 15.0,
                              height: 40.0,
                              minWidth: 100.0,
                              color: Colors.white,
                              textColor: Colors.orange,
                              child: new Text(
                                "Login",
                                 //style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              onPressed: ()=>{
                                print('insert backend data here')
                              },
                              splashColor: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: new MaterialButton(
                              elevation: 15.0,
                              height: 40.0,
                              minWidth: 100.0,
                              color: Colors.white,
                              textColor: Colors.orange,
                              child: new Text(
                              "Create an Account",
                              //style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              onPressed: ()=>{
                                print('insert backend data here')
                              },
                              splashColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}