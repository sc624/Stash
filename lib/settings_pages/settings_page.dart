import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SettingsPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Settings"),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        body: new ListView(
          children: <Widget>[
            new BigText(
              bigText: "Account",
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Container(
                child: new Card(
                  child: new ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme
                        .of(context)
                        .platform == TargetPlatform.iOS ? Colors.blue : Colors.white,
                      child: new Text("JD"),
                    ),
                    title: new Text('My Profile'),
                    onTap: () {
                      Navigator.of(context).pushNamed("Profile");
                    },
                  ),
                ),
              ),
            ),

            new Divider(),
            new BigText(
              bigText: "Location",
            ),
            new ListTile(
              title: new Text("Location"),
              subtitle: new Text("Champaign, IL"),
              onTap: () {
                Navigator.of(context).pushNamed("Location Settings");
              },
            ),

            new MaxDistance(),

            new Divider(),
            new BigText(
              bigText: "Notifications",
            ),
            new PushNotification(),
            new EmailNotification(),

            new Divider(),
            new BigText(
              bigText: "Contact Us",
            ),
            new PlainTile(
              label: "Contact the Stash Team",
              route: "Contact Us",
            ),

            new Divider(),
            new BigText(
              bigText: "Legal",
            ),
            new PlainTile(
              label: "Privacy Policy",
              route: "Privacy Policy",
            ),
            new PlainTile(
              label: "Terms of Service",
              route: "Terms of Service",
            ),
            new PlainTile(
              label: "Licenses",
              route: "Licenses",
            ),

            new Divider(),
            new ListTile(
              title: new Text(
                "Logout",
                style: TextStyle(color: Colors.red),
                textScaleFactor: 1.2,
              ),
              onTap: () {
                Navigator.of(context).pushNamed("Logout");
              },
            ),
          ],
        ),
      );
    }
}

// Maximum Distance Slider
class MaxDistance extends StatefulWidget {
  @override
  MaxDistanceState createState() => new MaxDistanceState();
}

class MaxDistanceState extends State<MaxDistance> {
  double minVal = 0.0;
  double maxVal = 100.0;
  double sliderVal = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          title: new Text("Maximum Distance"),
          trailing: new Text("${sliderVal.round()} mi"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Slider(
            value: sliderVal,
            min: minVal,
            max: maxVal,
            divisions: 100,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            onChanged: (newVal) {
              setState(() {
                sliderVal = newVal;
              });
            },
            semanticFormatterCallback: (double newVal) {
              return "${newVal.round()} mi";
            },
          ),
        ),
      ]
    );
  }
}

// Push Notification SwitchListTile
class PushNotification extends StatefulWidget {
  @override
  PushNotificationState createState() => new PushNotificationState();
}

class PushNotificationState extends State<PushNotification> {
  bool onOff = true;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Push Notifications"),
      activeColor: Colors.blue,
      value: onOff,
      onChanged: (bool value) { setState(() { onOff = value; });
      },
    );
  }
}

// Email Notification SwitchListTile
class EmailNotification extends StatefulWidget {
  @override
  EmailNotificationState createState() => new EmailNotificationState();
}

class EmailNotificationState extends State<EmailNotification> {
  bool onOff = true;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Email Notifications"),
      activeColor: Colors.blue,
      value: onOff,
      onChanged: (bool value) { setState(() { onOff = value; });
      },
    );
  }
}

// Settings big text class
class BigText extends StatelessWidget {
  final String bigText;

  BigText({this.bigText});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: new Text(
        bigText,
        style: TextStyle(fontWeight: FontWeight.bold),
        textScaleFactor: 1.2,
      ),
    );
  }
}

// Settings plain ListTiles class
class PlainTile extends StatelessWidget {
  final String label;
  final String route;

  PlainTile({
    this.label,
    this.route
  });

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(label),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}