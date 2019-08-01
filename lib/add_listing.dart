import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stash/globals.dart' as globals;
//import 'dart:async';
import 'dart:convert';


  



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

List data2, data3, data4, data5;
var data1, price, low, high;
var n1, n2, n3, n4, n5;
var lt1, p1, c1, s1, d1;
var lt2, p2, c2, s2, d2;
var lt3, p3, c3, s3, d3;
var lt4, p4, c4, s4, d4;
var parsed = '';
String hi;

 Future<Null> printData() async {
    var url = Uri.encodeFull("https://mysterymachine.web.illinois.edu/printData.php");
    var response = await http.post(url,
      headers: {
        "Accept": "application/json"
      },
      body: {
        "Description": desc,
        "dimensions": dim,
        "city": city,
        "state": state,
      },
    );

    data1 = json.decode(response.body);
    
    for(int i = 0; i < data1.length; i++){
      parsed += data1[i];
    }
     price = parsed.split("TIRED")[0];
     low = parsed.split("TIRED")[1];
     high = parsed.split("TIRED")[2];
     n1 = parsed.split("TIRED")[3];
      lt1 = n1.split("NEIGH1")[0];
      p1 = n1.split("NEIGH1")[1];
      c1 = n1.split("NEIGH1")[2];
      s1 = n1.split("NEIGH1")[3];
      d1 = n1.split("NEIGH1")[4];
    //  n2 = parsed.split("TIRED")[4];
    //  lt2 = n2.split("NEIGH2")[0];
    //   p2 = n2.split("NEIGH2")[1];
    //   c2 = n2.split("NEIGH2")[2];
    //   s2 = n2.split("NEIGH2")[3];
    //   d2 = n2.split("NEIGH2")[4];
     n3 = parsed.split("TIRED")[5];
     lt3 = n3.split("NEIGH3")[0];
      p3 = n3.split("NEIGH3")[1];
      c3 = n3.split("NEIGH3")[2];
      s3 = n3.split("NEIGH3")[3];
      d3 = n3.split("NEIGH3")[4];
    //  n4 = parsed.split("TIRED")[6];
    //  lt4 = n1.split("NEIGH4")[0];
    //   p4 = n1.split("NEIGH4")[1];
    //   c4 = n1.split("NEIGH4")[2];
    //   s4 = n1.split("NEIGH4")[3];
    //   d4 = n1.split("NEIGH4")[4];
    
    print(n3);
  }

  @override
  void initState() {
    this.printData();
  }


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
         Padding(
            padding: const EdgeInsets.only(left: 17.5, top: 15.0),
            child: Text(
              "Stash Price Recommendation Range: $low to $high" ,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ),
          Card(
            child: ListTile(
              title: Text(lt1 + " costs \$" + p1 + " in " + c1 + "\, " + s1),
              subtitle: Text(d1),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(lt3 + " costs \$" + p3 + " in " + c3 + "\, " + s3),
              subtitle: Text(d3),
            ),
          ),
          ],
        ),
    );

  }   
}