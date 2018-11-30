import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
            child: RaisedButton(
                child: Text('Like my Work ?'),
                onPressed: () {
                  containerForSheet<String>(
                    context: context,
                    child: CupertinoActionSheet(
                        title: const Text('Choose frankly 😊'),
                        message: const Text(
                            'Your options are '),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('🙋 Yes'),
                            onPressed: () {
                              Navigator.pop(context, '🙋 Yes');
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('🙋 No'),
                            onPressed: () {
                              Navigator.pop(context, '🙋 No');
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text("🙋 Can't say"),
                            onPressed: () {
                              Navigator.pop(context, "🙋 Can't say");
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text("🙋 Decide in next post"),
                            onPressed: () {
                              Navigator.pop(context, "🙋 Decide in next post");
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                        )),
                  );
                }),
          );
        },
      ),
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('You clicked $value'),
        duration: Duration(milliseconds: 800),
      ));
    });
  }
}
