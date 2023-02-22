import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

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
  int _counterScreenCount = 0;
  final _streamController = StreamController<void>.broadcast();

  String _url = 'flutter.dev';
  bool _isShown = true;

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    // These two are used inside the [js/js-interop.js]
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod<void>(js_util.globalThis, '_stateSet', []);
  }

  @js.JSExport()
  void getValue(String payload) {
    setState(() {
      _url = payload;
      // This line makes sure the handler gets invoked
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void showHideValue(bool val) {
    setState(() {
      _isShown = val;
      // This line makes sure the handler gets invoked
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void increment() {
    setState(() {
      _counterScreenCount++;

      // This line makes sure the handler gets invoked
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void addHandler(void Function() handler) {
    // This registers the handler we wrote in [js/js-interop.js]
    _streamController.stream.listen((event) {
      handler();
    });
  }

  @js.JSExport()
  int get count => _counterScreenCount;

  @js.JSExport()
  String get showHideNav => _isShown ? 'Hide Navigation' : 'Show Navigation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counterScreenCount',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            if (_isShown)
              ElevatedButton(
                onPressed: () => _launchUrl(_url),
                child: Text('Going to $_url'),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final toLaunch = Uri(scheme: 'https', host: url);
    window.open(toLaunch.toString(), 'new tab');
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
