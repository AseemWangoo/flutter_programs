import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text(
          'Profile',
          style: const TextStyle(fontSize: 19.0),
        ),
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data as Map<String, dynamic>);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget body(Map data) {
    return Container(      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              backgroundImage: NetworkImage('https://robohash.org/aseem'),
              maxRadius: 40.0,
            ),
          ),
          Divider(),
          Text('Profile Details'),
          Container(            
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Table(
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text('ID'),
                          new Text(data['id'].toString()),
                        ],
                      ),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text('Name'),
                          new Text(data['employee_name'].toString()),
                        ],
                      ),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text('Salary'),
                          new Text(data['employee_salary'].toString()),
                        ],
                      ),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text('Age'),
                          new Text(data['employee_age'].toString()),
                        ],
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> loadData() async {
    http.Response response = await http.get(
        Uri.parse("http://dummy.restapiexample.com/api/v1/employee/52"),
        headers: {"Accept": "application/json"});
    Map data = jsonDecode(response.body);
    return data;
  }
}
