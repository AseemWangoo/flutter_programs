import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color _colorOne = Color(0x33000000); 
const Color _colorTwo = Color(0x24000000); 
const Color _colorThree = Color(0x1F000000); 

void main() {
  runApp(new CupertinoSegmentedControlDemo());
}

class CupertinoSegmentedControlDemo extends StatefulWidget {

  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Logo 1'),
    1: Text('Logo 2'),
    2: Text('Logo 3'),
  };

  final Map<int, Widget> icons = const <int, Widget>{
    0: Center(
      child: FlutterLogo(
        colors: Colors.indigo,
        size: 200.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
        colors: Colors.teal,
        size: 200.0,
      ),
    ),
    2: Center(
      child: FlutterLogo(
        colors: Colors.cyan,
        size: 200.0,
      ),
    ),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: const Text('Flutter SegmentedControl'),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
            ),
            SizedBox(
              width: 500.0,
              child: CupertinoSegmentedControl<int>(
                children: logoWidgets,
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 16.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 64.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: -1.0,
                        color: _colorOne,
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        color: _colorTwo,
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 18.0,
                        spreadRadius: 0.0,
                        color: _colorThree,
                      ),
                    ],
                  ),
                  child: icons[sharedValue],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
