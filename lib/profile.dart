import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Profile"),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        body: new ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new CircleAvatar(
                radius: 36.0,
                backgroundColor: Theme
                  .of(context)
                  .platform == TargetPlatform.iOS ? Colors.blue : Colors.white,
                child: new Text("JD"),
              ),
            ),
            new ProfileButton(
              label: "First Name",
              subtitle: "John",
              route: "First Name Settings",
            ),
            new ProfileButton(
              label: "Last Name",
              subtitle: "Doe",
              route: "Last Name Settings",
            ),
            new ProfileButton(
              label: "Phone Number",
              subtitle: "(000) 000-0000",
              route: "Phone Settings",
            ),
            new ProfileButton(
              label: "Email",
              subtitle: "example@email.com",
              route: "Email Settings",
            ),
            new ProfileButton(
              label: "Password",
              subtitle: "Obscured password here",
              route: "Password Settings",
            ),
          ],
        ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String label;
  final String subtitle;
  final String route;

  ProfileButton({
    this.label,
    this.subtitle,
    this.route
  });

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(label),
      subtitle: new Text(subtitle),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}