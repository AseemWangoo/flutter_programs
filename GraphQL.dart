import 'package:flutter/material.dart';
import 'package:scalable_image/scalable_image.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'modifiedscreen.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'addStar.dart' as mutations;
import 'readRepositories.dart' as queries;
import 'feedList.dart' as feedList;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Client> client = ValueNotifier(
      Client(
        endPoint: 'https://api.github.com/graphql',
        cache: InMemoryCache(),
        apiToken: '<Enter your token here>',
      ),
    );

    return GraphqlProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        "query ReadRepositories {" +
            "    viewer {" +
            "      repositories(last: 50) {" +
            "        nodes {" +
            "          id" +
            "          name" +
            "          viewerHasStarred" +
            "        }" +
            "      }" +
            "    }" +
            "  }",
        builder: ({
          bool loading,
          Map data,
          Exception error,
        }) {
          if (error != null) {
            return Text(error.toString());
          }

          if (loading) {
            return Text('Loading');
          }
          

          // it can be either Map or List
          List feedList = data['viewer']['repositories']['nodes'];

          return ListView.builder(
            itemCount: feedList.length,
            itemBuilder: (context, index) {
              final feedListItems = feedList[index];
              // List tagList = feedListItems['name'];              
              return new Card(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: new Text(feedListItems['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
