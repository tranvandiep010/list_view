import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listview Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
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
                          new Text("Listview"),
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
      ),
    );
  }
}
