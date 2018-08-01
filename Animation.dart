import 'package:flutter/material.dart';

void main() {
  runApp(new ProjectApp());
}

class ProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Uploader',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainScreen(title: 'Uploader Screen'),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MainScreenState createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = Tween(begin: 0.0, end: 300.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      )),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            print("Snack bar clicked");
          },
          child: new Icon(Icons.gavel)),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
