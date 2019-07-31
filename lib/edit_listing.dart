import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:stash/my_listings.dart';
//import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stash/globals.dart' as globals;

class EditListingPage extends StatefulWidget {
  @override
  _EditListingPage createState() => _EditListingPage("Edit Listing");
}

class _EditListingPage extends State<EditListingPage> {

  List data;

  /*-------------all text edit fields------------*/
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController dimController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  _EditListingPage(this.title);
  final String title;



  //back end call to get current listing
  Future<Null> getData() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/getListingInfo.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
      body: {
        "listingid": globals.lID,
      },
    );
    this.setState((){
      data = json.decode(response.body);
    });

    typeController.text = data[0]['ListingType'];
    dimController.text = data[0]['Dimensions'];
    priceController.text = data[0]['ListingPrice'];
    streetController.text = data[0]['StreetName'];
    zipController.text = data[0]['ZipCode'];
    cityController.text = data[0]['City'];
    stateController.text = data[0]['State'];
  }


  @override
  void initState(){
    this.getData();
  }

  /*-------------backend update function------------*/
  void _updateData() {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/updateListing.php");

    http.post(url, body: {
       "listingtype": typeController.text,
       "dimensions": dimController.text,
       "listingprice": priceController.text,
       "streetname": streetController.text,
       "zipcode": zipController.text,
       "city": cityController.text,
       "state": stateController.text,
       "listingid": globals.lID,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Listing"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
       floatingActionButton: Align(
          child: FloatingActionButton.extended(
            icon: Icon(Icons.save_alt),
            label: Text("Save",
            style: TextStyle(fontSize: 14.0)),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            onPressed: (){
              _updateData();
              //Navigator.pop(context,true);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
              context,
              new MaterialPageRoute (
                  builder: (BuildContext context) => new MyListingsPage()),
            );
          },
        ),
        alignment: Alignment(0.10,0.925)),
        body: new ListView(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.only(left: 17.5, top: 15.0),
              child: const Text(
                "Listing Type",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: typeController,
                onChanged: (v) => typeController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hintText: 'e.g. Garage Space',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.5, top: 15.0),
              child: const Text(
                "Listing Price",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: priceController,
                onChanged: (v) => priceController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: "e.g. Price Per Month",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.5, top: 15.0),
              child: const Text(
              "Dimensions",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: dimController,
                onChanged: (v) => dimController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'e.g. 5x5x5',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.5, top: 15.0),
              child: const Text(
                "Address",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left:15.0, right: 15.0, bottom: 3.0),
              child: TextField(
                controller: streetController,
                onChanged: (v) => streetController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'Street Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, left:15.0, right: 15.0, bottom: 3.0),
              child: TextField(
                controller: zipController,
                onChanged: (v) => zipController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'Zip Code',
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, left:15.0, right: 15.0, bottom: 3.0),
              child: TextField(
                controller: cityController,
                onChanged: (v) => cityController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'City',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, left:15.0, right: 15.0, bottom: 3.0),
              child: TextField(
                controller: stateController,
                onChanged: (v) => stateController.text = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.deepOrange,
                  hasFloatingPlaceholder:true,
                  hintText: 'State',
                ),
              ),
            ),
          ],
        ),
    );
  }
}