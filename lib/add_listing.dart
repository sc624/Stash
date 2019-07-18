import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:stash/all_listings.dart';
//import 'dart:async';
import 'package:http/http.dart' as http;
//import 'dart:convert';

class AddListingPage extends StatefulWidget {
  @override
  _AddListingPage createState() => _AddListingPage("Add Listing");
}
  

class _AddListingPage extends State<AddListingPage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  //check boxes for type? 
  //TextEditingController typeController = TextEditingController();
  TextEditingController dimController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  _AddListingPage(this.title);
  final String title;

  void _addData() {

    var url = "https://mysterymachine.web.illinois.edu/addListing.php";
           
    http.post(url, body: {
      
       "listingtype": typeController.text,
       "dimensions": dimController.text,
       "listingprice": priceController.text,
       "streetname": streetController.text,
       "zipcode": zipController.text,
       "city": cityController.text,
       "state": stateController.text,

    });      

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
          label: Text("Post Listing",
          style: TextStyle(fontSize: 15.0)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            _addData();
          },
        ),
        alignment: Alignment(0.12,0.94)),
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
         padding: const EdgeInsets.only(top: 6.0, left:15.0, right: 15.0, bottom: 3.0),
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
          inputFormatters: [
           WhitelistingTextInputFormatter.digitsOnly,
           ],
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
      )
      
    );
  }
}