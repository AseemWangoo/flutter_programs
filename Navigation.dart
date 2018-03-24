import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ButtonOptions(),
      routes: <String, WidgetBuilder>{
        '/SecondScreen': (BuildContext context) => new SecondScreen(),
      }, //define the routes here
    );
  }
}

class ButtonOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ButtonOptionsState();
  }
}

class ButtonOptionsState extends State<ButtonOptions> {
  @override
  Widget build(BuildContext context) {
    String _route = "/SecondScreen";
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('First Screen'),
        ),
        body: new Center(
            child: new Container(
          child: new RaisedButton(
            textColor: Colors.blue,
            child: new Text("Click me"),
            onPressed: () {
              Navigator.of(context).pushNamed(_route);
            },
          ),
        )));
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SecondScreenMode();
  }
}

class SecondScreenMode extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: new AppBar(
      title: new Text('Second Screen'),
      automaticallyImplyLeading: false,
    ));
  }
}
