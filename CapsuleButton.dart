import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new UserOptions(), // Default or main screen of the app
    );
  }
}

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.blueGrey,
      body: new Center(
          child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Builder(
              builder: (BuildContext context) {
                return new Material(                  
                  borderRadius: new BorderRadius.circular(30.0),
                  child: new Material(
                    elevation: 5.0,
                    child: new MaterialButton(                      
                      //padding: new EdgeInsets.all(16.0),                      
                      minWidth: 150.0,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('You clicked manual'),
                            ));
                      },
                      child: new Text('Go manual'),
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                );
              },
            ),
            new Builder(
              builder: (BuildContext context) {
                return new Material(                  
                  borderRadius: new BorderRadius.circular(30.0),
                  child: new Material(
                    elevation: 5.0,
                    child: new MaterialButton(
                      minWidth: 150.0,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('You clicked pro'),
                            ));
                      },
                      child: new Text('Go Pro'),
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                );                
              },
            )
          ],
        ),
        
      )),
    );
  }
}
