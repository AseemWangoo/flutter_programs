import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //for making request
import 'dart:async'; //for asynchronous features
import 'dart:convert';//PlatForm Exception

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppScreenMode();
  }
}

class MyAppScreenMode extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Future Builder',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('Future Builder'),
            ),
            body: new Center(
              child: new MiddleSection(),
            )));
  }
}

class MiddleSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MiddleSectionState();
  }
}

class MiddleSectionState extends State<MiddleSection> {
  String display;

  Widget futureWidgetOnButtonPress() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      // if(snapshot.hasData){return new Text(display);}    //does not display updated text
      if (display != null) {
        return new Text(display);
      }
      return new Text("no data yet");
    });
  }

  Future<Null> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    List data = JSON.decode(response.body);
    print(data[2]['title'].toString());
    setState(() {
      display = data[2]['title'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.yellowAccent,
        width: 250.0,
        padding: const EdgeInsets.all(10.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new RaisedButton(
                child: new Text("Send"),
                onPressed: getData,
              ),
              futureWidgetOnButtonPress()
            ]));
  }
}

Future<String> getDataFB() async {
  http.Response response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {"Accept": "application/json"});
  List data = JSON.decode(response.body);
  print(data[1]['title'].toString());
  return data[1]['title'].toString();
}
