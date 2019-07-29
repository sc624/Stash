import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:stash/my_listings.dart';
import 'package:flutter/services.dart';
import 'package:stash/all_listings.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

//custom card
class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.subtitle2,
    this.subtitle3,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String subtitle2;
  final String subtitle3;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                '$subtitle2',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                '$subtitle3',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Seller: $author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate · \$$readDuration/month',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.subtitle2,
    this.subtitle3,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String subtitle2;
  final String subtitle3;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  subtitle2: subtitle2,
                  subtitle3: subtitle3,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class AllListingsPage extends StatefulWidget {
  @override
  _AllListingsPage createState() => _AllListingsPage("All Listings");
}
  

class _AllListingsPage extends State<AllListingsPage> {
  _AllListingsPage(this.title);
  final String title;
  TextEditingController searchController = TextEditingController();

  List data1;

  //finds all listing prices
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

  //find all listings lower than price
  Future<String> _findData() async {
    var response = await http.post(
      Uri.encodeFull("https://mysterymachine.web.illinois.edu/priceFilter.php"),
      headers: {"Accept": "application/json"},
      body: {"listingprice": searchController.text,}
    );
    this.setState((){
      data1 = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState(){
    this._fetchAll();
    this._findData();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("All Listings"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.search),
          label: Text("Search",
          style: TextStyle(fontSize: 14.0)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          onPressed: (){
            _findData();
          },
        ),
        alignment: Alignment(0.12,0.45)),
      body: new ListView(
      children: <Widget> [
         Padding(
            padding: const EdgeInsets.only(left: 17.5, top: 10.0),
            child: const Text(
              "Find listings with prices less than: ",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
          ), 
         Padding(
         padding: const EdgeInsets.all(15.0),
         child: TextField(
           controller: searchController,
           onChanged: (v) => searchController.text = v,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             fillColor: Colors.deepOrange,
             hintText: 'e.g. 20',
          ), 
         ),
         ),
         new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data1 == null ? 0 : data1.length,
          itemBuilder: (BuildContext context, int index){
            return new GestureDetector(
//              onTap:(
//
//              ),
              child: new Card(
                //custom list tile
                child:CustomListItemTwo(
                  thumbnail: Container(
                    decoration: const BoxDecoration(color: Colors.pink),
                  ),
                  title: data1[index]["ListingType"],
                  subtitle: data1[index]["StreetName"],
                  subtitle2: data1[index]["City"],
                  subtitle3: data1[index]["State"],
                  author: data1[index]["Username"],
                  publishDate: data1[index]["Email"],
                  readDuration: data1[index]["ListingPrice"],
                ),
              ),
            );
        },
      ),
      ],
      ),
    );

  }
}