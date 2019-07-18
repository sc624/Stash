import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:stash/all_listings.dart';

class AddListingPage extends StatelessWidget {
  final String title;

  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  //check boxes for type? 
  //TextEditingController typeController = TextEditingController();
  TextEditingController dimController = TextEditingController();
  TextEditingController locController = TextEditingController();

  AddListingPage(this.title);

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
          style: TextStyle(fontSize: 14.5)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllListingsPage("All Listings")),
            );
          },
        ),
        alignment: Alignment(0.12,0.65)),
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
           controller: titleController,
           onChanged: (v) => titleController.text = v,
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
           inputFormatters: [
           WhitelistingTextInputFormatter.digitsOnly,
           ],
           keyboardType: TextInputType.phone,
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
              "Address/Location",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
         ),
         Padding(
         padding: const EdgeInsets.all(15.0),
         child: TextField(
           controller: locController,
           onChanged: (v) => locController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.deepOrange,
             hasFloatingPlaceholder:true,
             hintText: 'e.g. 606 E. Green St.',
          ), 
         ),
         ),
        ],        
      )
      
    );
  }
}