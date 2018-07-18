import 'package:flutter/material.dart';

void main() {
  runApp(new RectangleClass());
}

class RectangleClass extends StatefulWidget {
  @override
  DrawRect createState() => new DrawRect();
}

class DrawRect extends State<RectangleClass> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Shapes in Flutter'),
          ),
          body: new Stack(
            children: <Widget>[
              new CustomPaint(
                painter: new Sample(),
              )
            ],
          )),
    );
  }
}

class Sample extends CustomPainter {
  //PaintingStyle.stroke;   //This allows to shade only the borders
  //strokeWidth = sets the width of rectangle
  final customPaint = new Paint()
    ..color = new Color(0xFF0099FF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  //Circle - dx and dy components
  final offsetCircle = new Offset(200.0, 200.0);  

  final _drawRect = new Rect.fromLTRB(150.0, 150.0, 10.0, 400.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_drawRect, customPaint);
    canvas.drawCircle(offsetCircle, 30.0, customPaint);
    canvas.drawOval(_drawRect, customPaint);    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
