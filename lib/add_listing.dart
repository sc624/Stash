import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stash/globals.dart' as globals;

//import 'dart:async';
//import 'dart:convert';

String type, dim, desc, street, city, state, zip;


class AddListingPage extends StatefulWidget {
  @override
  _AddListingPage createState() => _AddListingPage("Add Listing");
}


class _AddListingPage extends State<AddListingPage> {

  /*------------------------all controllers---------------------*/
  //TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  //check boxes for type? 
  TextEditingController dimController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  _AddListingPage(this.title);
  final String title;


  // void _addData() {

  //   var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/addListing.php");
           
  //   http.post(url, body: {
  //     "userid" : globals.userID,
  //     "listingtype": typeController.text,
  //     "dimensions": dimController.text,
  //     "Description": descriptionController.text,
  //     "streetname": streetController.text,
  //     "zipcode": zipController.text,
  //     "city": cityController.text,
  //     "state": stateController.text,
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("List Your Space"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      floatingActionButton: Align(
          child: FloatingActionButton.extended(
          icon: Icon(Icons.arrow_forward),
          label: Text("Next",
          style: TextStyle(fontSize: 14.0)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            setState(() {
              type = typeController.text;
              dim = dimController.text;
              desc = descriptionController.text;
              street = streetController.text;
              city = cityController.text;
              state = stateController.text;
              zip = zipController.text;
            });
            //_addData();
            //Navigator.of(context).pop();
            //Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListingConfirmationPage()),
            );
          },
        ),
        alignment: Alignment(0.12,0.92)),
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
         padding: const EdgeInsets.only(top: 10.0, left:15.0, right: 15.0),
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
              "Dimensions (feet)",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
        Padding(
         padding: const EdgeInsets.only(left:15.0, top: 10.0,right: 15.0),
         child: TextField(
           controller: dimController,
           onChanged: (v) => dimController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.orange,
             hasFloatingPlaceholder:true,
             hintText: 'e.g. 10x10',
          ), 
         ),
         ),
         Padding(
            padding: const EdgeInsets.only(left: 17.5, top: 15.0),
            child: const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ), 
        Padding(
          padding: const EdgeInsets.only(left:15.0, top:10.0, right: 15.0),
          child: TextField(
            maxLines: 4,
            controller: descriptionController,
            onChanged: (v) => descriptionController.text = v, 
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.orange,
                hasFloatingPlaceholder: true,
                hintText: 'Tell us a little about your space...',
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
             fillColor: Colors.orange,
             hasFloatingPlaceholder:true,
             hintText: 'Street Name',
          ), 
         ),
         ),
          Padding(
         padding: const EdgeInsets.only(top: 3.0, left:15.0, right: 15.0, bottom: 3.0),
         child: TextField(
           controller: cityController,
           onChanged: (v) => cityController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.orange,
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
        Padding(
         padding: const EdgeInsets.only(top: 3.0, left:15.0, right: 15.0, bottom: 3.0),
         child: TextField(
           controller: zipController,
           onChanged: (v) => zipController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.deepOrange,
             hasFloatingPlaceholder:true,
             hintText: 'Zipcode',
          ),
          inputFormatters: [
           WhitelistingTextInputFormatter.digitsOnly,
           ],
           keyboardType: TextInputType.phone, 
         ),
         ),
          
        ],
      )
      
    );
  }
}




class ListingConfirmationPage extends StatefulWidget {
  @override
  ListingConfirmationPageState createState() => new ListingConfirmationPageState();
}

class ListingConfirmationPageState extends State<ListingConfirmationPage> {

TextEditingController priceController = TextEditingController();


  void _addData() {

    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/addListing.php");
           
    http.post(url, body: {
      "userid" : globals.userID,
      "listingprice": priceController.text,
      "listingtype": type,
      "dimensions": dim,
      "Description": desc,
      "streetname": street,
      "zipcode": zip,
      "city": city,
      "state": state,
    });

  }

 @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Confirmation Page"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      floatingActionButton: Align(
          child: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Post Listing",
          style: TextStyle(fontSize: 14.0)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            //print(type);
            _addData();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(
            context,
             new MaterialPageRoute (
                   builder: (BuildContext context) => new MyListingsPage()),
             );
          },
        ),
        alignment: Alignment(0.12,0.85)),
        body: new ListView(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: 17.5, top: 15.0),
            child: const Text(
              "Listing Price",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
         padding: const EdgeInsets.only(top: 10.0, left:15.0, right: 15.0),
         child: TextField(
           controller: priceController,
           onChanged: (v) => priceController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.orange,
             hintText: 'e.g. 29',
                ), 
            ),
         ),
        ],

        ),
        );

  }   
}