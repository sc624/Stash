import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Main Pages
import 'package:stash/profile_page.dart';
import 'package:stash/settings_pages/settings_page.dart';
import 'package:stash/about_page.dart';
import 'package:stash/all_listings.dart';
import 'package:stash/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stash/edit_listing.dart';
import 'package:stash/globals.dart' as globals;
// Nested Settings Pages
import 'package:stash/settings_pages/subpages/name_settings.dart';
import 'package:stash/settings_pages/subpages/password_settings.dart';
import 'package:stash/settings_pages/subpages/phone_settings.dart';
import 'package:stash/settings_pages/subpages/email_settings.dart';
import 'package:stash/settings_pages/subpages/location_settings.dart';
//import 'package:stash/settings_pages/subpages/my_listings_settings.dart';
import 'package:stash/my_listings.dart';
import 'package:stash/add_listing.dart';
import 'package:stash/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    print('1 = login page, 0 = main screen: ${globals.lol}');
    if(globals.lol == 1){
      globals.page = new LoginPage();
      globals.lol--;
    } else{
      globals.page = new MyHomePage();
    }
    return MaterialApp(
        title: 'Stash',
        theme: ThemeData(
          // This is the theme of your application.
            primarySwatch: Colors.deepOrange,
            primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.white : null
        ),
        home: globals.page,
        routes: <String, WidgetBuilder>{
          "Profile": (BuildContext context) => new ProfilePage(),
          "First Name Settings": (BuildContext context) => new FirstNamePage(),
          "Last Name Settings": (BuildContext context) => new LastNamePage(),
          "Password Settings": (BuildContext context) => new PasswordSettingsPage(),

          //"Messages": (BuildContext context) => new MessagesPage("Messages"),
          // "History": (BuildContext context) => new HistoryPage("History"),

          //"Payment": (BuildContext context) => new PaymentPage(),
          //"Add Card": (BuildContext context) => new AddCardPage(),

          "Settings": (BuildContext context) => new SettingsPage(),
          "Phone Settings": (BuildContext context) => new PhoneSettingsPage(),
          "Email Settings": (BuildContext context) => new EmailSettingsPage(),
          "Location Settings": (BuildContext context) => new LocationSettingsPage("Location Settings"),
          //"My Listings Settings": (BuildContext context) => new MyListingsSettingsPage("My Listings"),
          //"Contact Us": (BuildContext context) => new HelpSupportPage(),
          //"Privacy Policy": (BuildContext context) => new PrivacyPolicyPage(),
          //"Terms of Service": (BuildContext context) => new TermsOfServicePage(),
          //"Licenses": (BuildContext context) => new LicensesPage("Licenses"),
          "Logout": (BuildContext context) => new LoginPage(),
          "Main" : (BuildContext context) => new MyHomePage(),
          "About": (BuildContext context) => new AboutPage(),
          "All Listings": (BuildContext context) => new AllListingsPage(),
          "My Listings": (BuildContext context) => new MyListingsPage(),
          "Login": (BuildContext context) => new LoginPage(),
        },
    );

  }
}


class MyHomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(40.1020, -88.2272);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  var test= globals.username;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("${globals.firstname}"),
              accountEmail: new Text("${globals.useremail}"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Theme
                    .of(context)
                    .platform == TargetPlatform.iOS ? Colors.orange : Colors.white,
                child: new Text("JD"),
              ),
              onDetailsPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("Profile");
              },
            ),
            new NavButton(
              label: "All Listings",
              route: "All Listings",
            ),
            new Divider(),
            new NavButton(
              label: "My Listings",
              route: "My Listings",
            ),
            new Divider(),
            new NavButton(
              label: "Settings",
              route: "Settings",
            ),
            new Divider(),
            new NavButton(
              label: "About",
              route: "About",
            ),
          ],
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        myLocationButtonEnabled: true,
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final String route;

  const NavButton({
    this.label,
    this.route
  });

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(label),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(route);
        }
    );
  }
}