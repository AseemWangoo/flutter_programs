//import 'package:flutfire/mlkit/ml_detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mlkit/mlkit.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _file;

  List<VisionLabel> _currentLabels = <VisionLabel>[];

  FirebaseVisionLabelDetector detector = FirebaseVisionLabelDetector.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Image Labeling Firebase'),
        ),
        body: _buildBody(_file),
        floatingActionButton: new FloatingActionButton(
          onPressed: () async {
            try {
              var file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                _file = file;
              });

              var currentLabels =
                  await detector.detectFromBinary(_file?.readAsBytesSync());
              setState(() {
                _currentLabels = currentLabels;
              });
            } catch (e) {
              print(e.toString());
            }
          },
          child: new Icon(Icons.select_all),
        ),
      ),
    );
  }

  //Build body
  Widget _buildBody(File _file) {
    return new Container(
      child: new Column(
        children: <Widget>[displaySelectedFile(_file), _buildList(_currentLabels)],
      ),
    );
  }

  Widget _buildList(List<VisionLabel> labels) {
    if (labels == null || labels.length == 0 ) {
      return new Text('Empty', textAlign: TextAlign.center);
    }
    return new Expanded(
      child: new Container(    
        child: new ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: labels.length,
            itemBuilder: (context, i) {
              return _buildRow(labels[i].label, labels[i].confidence.toString(), labels[i].entityID);
            }),
      ),
    );
  }

   Widget displaySelectedFile(File file) {
    return new SizedBox(
      // height: 200.0,
      width: 150.0,
      child: file == null
          ? new Text('Sorry nothing selected!!')
          : new Image.file(file),
    );
}

  //Display labels
  Widget _buildRow(String label, String confidence, String entityID) {
    return new ListTile(
      title: new Text(
        "\nLabel: $label \nConfidence: $confidence \nEntityID: $entityID",
      ),
      dense: true,
    );
  }
}