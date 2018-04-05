import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  //for making request
import 'dart:async';  //for asynchronous features
import 'dart:convert';  //for converting the response to desired format. e.g: JSON
import 'package:connectivity/connectivity.dart';  //connectivity package...also see the pubspec.yaml
import 'package:flutter/services.dart'; //PlatForm Exception

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new ButtonOptions());
  }
}

class ButtonOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ButtonOptionsState();
  }
}

class ButtonOptionsState extends State<ButtonOptions> {
  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();

  //For subscription to the ConnectivityResult stream
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  /*
  ConnectivityResult is an enum with the values as { wifi, mobile, none }.
  */
  @override
  void initState() {
    super.initState();
    // initConnectivity(); before calling on button press
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result.toString();
      });
    });
    print("Initstate : $_connectionStatus");
  }

  //For cancelling the stream subscription...Good way to release resources
  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  //called in initState
  /*
    _connectivity.checkConnectivity() checks the connection state of the device.
    Recommended way is to use onConnectivityChanged stream for listening to connectivity changes.
    It is done in initState function.
  */
  Future<Null> initConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = "Internet connectivity failed";
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
    print("InitConnectivity : $_connectionStatus");
    if(_connectionStatus == "ConnectivityResult.mobile" || _connectionStatus == "ConnectivityResult.wifi") {
      getData();
    } else {
      print("You are not connected to internet");
    }
  }

  //makes the request
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    List data = JSON.decode(response.body);
    print(data[1]);
  }

  final TextEditingController _controller = new TextEditingController();
  String str = "";
  String submitStr = "";

  void _changeText(String val) {
    setState(() {
      submitStr = val;
    });
    print("On RaisedButton : The text is $submitStr");
  }

  void _onSubmit(String val) {
    print("OnSubmit : The text is $val");
    setState(() {
      submitStr = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onChanged(String value) {
      print('"OnChange : " $value');
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: "Type something...",
              ),
              onChanged: (String value) {
                _onChanged(value);
              },
              controller: _controller,
              onSubmitted: (String submittedStr) {
                _onSubmit(submittedStr);
                _controller.text = "";
              },
            ),
            new Text('$submitStr'),
            new RaisedButton(
              child: new Text("Click me"),
              onPressed: () {
                //_changeText(_controller.text);
                //getData();
                initConnectivity();                
                // countT();
                _controller.text = _connectionStatus;
              },              
            )
          ],
        ),
      ),
    );
  }
}
