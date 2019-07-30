import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
import 'package:stash/globals.dart' as globals;
// Nested Settings Pages
import 'package:stash/settings_pages/subpages/name_settings.dart';
import 'package:stash/settings_pages/subpages/password_settings.dart';
import 'package:stash/settings_pages/subpages/phone_settings.dart';
import 'package:stash/settings_pages/subpages/email_settings.dart';
import 'package:stash/settings_pages/subpages/location_settings.dart';
//import 'package:stash/settings_pages/subpages/my_listings_settings.dart';
import 'package:stash/my_listings.dart';


import 'dart:async';


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
            primarySwatch: Colors.orange,
            primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.white : null
        ),
        // home: globals.page,
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
  Completer<GoogleMapController> _controller = Completer();

  List data1; 

    @override
  void initState() {
    //super.initState();
    this._fetchAll();
  }

  double zoomVal = 8.0;
  
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
                  .platform == TargetPlatform.iOS ? Colors.orange[100] : Colors.white,
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
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildContainer(),
          _zoomminusfunction(),
          _zoomplusfunction() 
        ],
      ),
    ); //scaffold 
  }


   Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(Icons.zoom_out),
            iconSize: 30.0,
            color: Colors.orange,
            onPressed: () {
              zoomVal--;
             _minus(zoomVal);
            }),
    );
 }

  Widget _zoomplusfunction() {
   
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
            icon: Icon(Icons.zoom_in),
            iconSize: 30.0,
            color: Colors.orange,
            onPressed: () {
              zoomVal++;
              _plus(zoomVal);
            }),
    );
 }


Future<String> _fetchAll() async {
    var response = await http.post(
      Uri.encodeFull("https://mysterymachine.web.illinois.edu/allListings.php"),
      headers: {"Accept": "application/json"},
    );
    this.setState((){
      data1 = json.decode(response.body);
    });
    return "Success!";
  }

 Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.1020, -88.2272), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.1020, -88.2272), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data1 == null ? 0 : data1.length,
          itemBuilder: (BuildContext context, int index){
          return new Container(
            //SizedBox(width: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3noC_-jIN-n5aXi1aBk5p0gWACCDkqDWlvvTppUMdrjRcoZt0",
                  40.112328, -88.235005,data1[index]["ListingType"], data1[index]["StreetName"],data1[index]["Username"], data1[index]["ListingPrice"]),
            ),
          ); 
          },
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String listingName, String streetname, String username, String listingprice ) {
    return  GestureDetector(
        onTap: () {
          _gotoLocation(lat,long);
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 160,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 30.0),
                            child: myDetailsContainer1(listingName, streetname, username, listingprice),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }

  Widget myDetailsContainer1(String listingName, String streetname, String username, String listingprice ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
          child: Container(
              child: Text(listingName,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
                child: Text(
                streetname,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
              )),
        SizedBox(height:5.0),
        Container(
          child: Padding(
          padding: const EdgeInsets.all(1.0),
              child: Text(
              "Host: " + username ,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  //fontWeight: FontWeight.bold
                ),
              ),
        ),
        ),
        SizedBox(height:5.0),
        Container(
          child: Padding(
          padding: const EdgeInsets.all(1.0),
              child: Text(
              "\$" + listingprice + " per month",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
        ),
        ),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(40.1020, -88.2272), zoom: 13.0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          host1Marker,host2Marker,host3Marker,
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 17,tilt: 40.0,
      bearing: 50.0,)));
  }
}//home class
 
Marker host1Marker = Marker(
  markerId: MarkerId('host1'),
  position: LatLng(40.112328, -88.235005),
  infoWindow: InfoWindow(title: 'Bicycle Storage Space'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);

Marker host2Marker = Marker(
  markerId: MarkerId('host2'),
  position: LatLng(40.107483, -88.218795),
  infoWindow: InfoWindow(title: 'Garage Storage Space'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);

Marker host3Marker = Marker(
  markerId: MarkerId('host3'),
  position: LatLng(40.105020, -88.234583),
  infoWindow: InfoWindow(title: 'Basement Storage Space'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),
);

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



