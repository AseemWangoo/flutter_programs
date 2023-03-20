import 'dart:async';

import 'package:flutter/material.dart';

import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@js.JSExport()
class _MyHomePageState extends State<MyHomePage> {
  String _textQuery = '';
  final TextEditingController _textController = TextEditingController();
  late FocusNode textFocusNode;
  final _streamController = StreamController<void>.broadcast();

  List<String> chatHistory = [];

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);

    // For text controllers
    textFocusNode = FocusNode();
    textFocusNode.requestFocus();

    // These two are used inside the [js/js-interop.js]
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod<void>(js_util.globalThis, '_stateSet', []);
  }

  @js.JSExport()
  void addHandler(void Function() handler) {
    // This registers the handler we wrote in [js/js-interop.js]
    _streamController.stream.listen((event) {
      handler();
    });
  }

  @js.JSExport()
  void textInputCallback(String value) {
    textFocusNode.requestFocus();
    setState(() {
      _textQuery = value;
      // This line makes sure the handler gets invoked
      _streamController.add(null);
    });
  }

  @js.JSExport()
  String get textQuery => _textQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textController,
              onChanged: (value) {
                setState(() => _textQuery = value);
              },
              onSubmitted: (value) {
                chatHistory.add(value);
                textInputCallback(value);
                handleClear();
              },
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type here...',
                labelText: 'Your Query',
              ),
            ),
            const SizedBox(height: 40),
            if (chatHistory.isNotEmpty)
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('History:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            for (var i = 0; i < chatHistory.length; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(chatHistory[i], textAlign: TextAlign.left),
                ],
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chatHistory.add(_textQuery);
          textInputCallback(_textQuery);
          handleClear();
        },
        tooltip: 'Send',
        child: const Icon(Icons.send),
      ),
    );
  }

  void handleClear() {
    setState(() {
      _textController.clear();
    });
    textFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _streamController.close();
    _textController.dispose();
    super.dispose();
  }
}
