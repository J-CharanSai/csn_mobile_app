import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mysql.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mysql_client/mysql_client.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var db = new Mysql();
  String? mail = '';

  void _incrementCounter() {
    _counter = _counter + 1;
    print(_counter);
    print("Button Pressed");
      var result = widget.pool.execute(
      "SELECT * FROM movie");

      result.then((value) {
        for (var r in value.rows) {
          print(r.assoc()['movie_title']);
          mail = r.assoc()['movie_title'];
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'mail:',
            ),
            Text(
              '$mail',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
