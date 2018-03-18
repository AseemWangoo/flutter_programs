import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new UserOptions(),
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
      appBar: new AppBar(
        title: new Text('data'),
      ),
      // body: new RaisedButton(
      //   child: const Text('Go manual'),
      //   onPressed: () {
      //     Scaffold.of(context).showSnackBar(new SnackBar(
      //        content: new Text('data'),
      //     ));
      //   },
      // ), //unable to fetch the context
      // body: new Builder(
      //   builder: (BuildContext context) {
      //     new RaisedButton(
      //       onPressed: () {
      //         Scaffold.of(context).showSnackBar(new SnackBar(
      //               content: new Text('You clicked me'),
      //             ));
      //       },
      //     );
      //   },
      // ), builder function must never return null
      body: new Builder(
        builder: (BuildContext context) {
          return new RaisedButton(
            child: new Text('Go manual'),
            onPressed: () {
              Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('You clicked me'),
                  ));
            },
          );
        },
      ),
    );
  }
}
