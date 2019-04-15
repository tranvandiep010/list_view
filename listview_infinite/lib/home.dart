import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  createState() => new HomeState();
}

class HomeState extends State<Home> {

  ScrollController controller;
  final _all = <int>[];
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    var arr = <int>[];
    for(int i  = 0; i < 20 ;i++){
      arr.add(itemCount);
      itemCount += 1;
    }
    _all.addAll(arr);
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      fetchData();
    });
  }

  fetchData() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, onResponse);
  }

  void onResponse() {
    var arr = <int>[];
    for(int i  = 0; i < 30 ;i++){
      arr.add(itemCount);
      itemCount += 1;
    }
    setState(() {
      isLoading = !isLoading;
      _all.addAll(arr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text(
          "List view load more",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          _buildSuggestions(),
          _loader(),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return new GestureDetector(
      child: new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: new Text("ListItem $index"),
            ),
          )
      ),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            child: new CupertinoAlertDialog(
              title: new Column(
                children: <Widget>[
                  new Text("Lirdview"),
                  new Icon(
                    Icons.favorite,
                    color: Colors.green,
                  )
                ],
              ),
              content: new Text("Selected Item $index"),
              actions: <Widget>[
                new FlatButton(onPressed: () {
                  Navigator.of(context).pop();
                },
                    child: new Text("OK")
                )
              ],
            )
        );
      },
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing.
        // For odd rows, the function adds a Divider widget to visually
        // separate the entries. Note that the divider may be difficult
        // to see on smaller devices.
        controller: controller,
        itemCount: _all.length,
        itemBuilder: (context, index) {
          // Add a one-pixel-high divider widget before each row in theListView.
          return _buildRow(_all[index]);
        });
  }

  Widget _loader() {
    return isLoading
        ? new Align(
      child: new Container(
        width: 70.0,
        height: 70.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(child: new CircularProgressIndicator())),
      ),
      alignment: FractionalOffset.bottomCenter,
    )
        : new SizedBox(
      width: 0.0,
      height: 0.0,
    );
  }
}