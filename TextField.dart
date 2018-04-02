import 'package:flutter/material.dart';

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
  final TextEditingController _controller = new TextEditingController();
  String str = "";
  String submitStr = "";
  
  //not used
  // int votes = 0;
  // void countT() {
  //   setState(() {
  //     votes++;
  //   });
  // }

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
                _changeText(_controller.text);
                // countT();
                _controller.text = "";
              },
            )
          ],
        ),
      ),
    );
  }
}
