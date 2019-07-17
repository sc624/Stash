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


// Nested Settings Pages
import 'package:stash/settings_pages/subpages/name_settings.dart';
import 'package:stash/settings_pages/subpages/password_settings.dart';
import 'package:stash/settings_pages/subpages/phone_settings.dart';
import 'package:stash/settings_pages/subpages/email_settings.dart';
import 'package:stash/settings_pages/subpages/location_settings.dart';
//import 'package:stash/settings_pages/subpages/my_listings_settings.dart';
import 'package:stash/my_listings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stash',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.orange,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.white : null
      ),
      home: MyHomePage(),
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

        "About": (BuildContext context) => new AboutPage(),
        "All Listings": (BuildContext context) => new AllListingsPage("All Listings"),
        "My Listings": (BuildContext context) => new MyListingsPage("My Listings"),
        "Login": (BuildContext context) => new LoginPage(),
      }
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  //bool mapToggle = false; 

  final LatLng _center = const LatLng(40.1020, -88.2272);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  
  

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
              accountName: new Text("John Doe"),
              accountEmail: new Text("jdoe2@illinois.edu"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Theme
                  .of(context)
                  .platform == TargetPlatform.iOS ? Colors.orange[300] : Colors.white,
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

  Future getData() async{
    var url = 'https://mysterymachine.web.illinois.edu/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  @override
  void initState(){
    getData();
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