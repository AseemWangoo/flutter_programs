import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //for making request
import 'dart:async'; //for asynchronous features
import 'dart:convert'; //PlatForm Exception

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
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new GradientBody(),
    );
  }
}

class GradientBody extends StatelessWidget {
  final List<String> images = [
    "assets/1.jpg",
    "assets/2.jpg",
    "assets/3.jpg",
  ];

  final List<String> numbers = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Gradients'),
      ),
      body: new Center(
        child: new SizedBox(
          // width: 200.0,
          height: 300.0,
          //child: const Card(child: const Text('Hello World!')),
          child: new PageView.builder(
            //similar to listview builder except that only 1 image is allowed at each time
            scrollDirection: Axis.horizontal,
            controller: new PageController(
              viewportFraction: 0.8, // if 1 then only 1 image in the screen
            ),
            itemCount: numbers.length,
            itemBuilder: (BuildContext context, int index) {              
              return new Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: new Material(
                  type: MaterialType.card,
                  elevation: 8.0,
                  borderRadius: new BorderRadius.circular(8.0),                  
                  child: new Stack(       //if fit not specified then, it aligns to top left....
                    fit: StackFit.expand,                    
                    children: <Widget>[
                      new Text(                        
                        numbers[index],
                        textScaleFactor: 5.0,
                        textAlign: TextAlign.center,                        
                      ),                      
                      new DecoratedBox(
                        decoration: new BoxDecoration(
                          //color: Colors.lightGreen
                          gradient: new LinearGradient(
                            begin: FractionalOffset.bottomLeft,
                            end: FractionalOffset.topRight,
                            colors: [       
                              const Color(0x5a0b486b),                       
                              const Color(0xFFF56217),                              
                            ]
                          )
                        ),
                      ), 
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
