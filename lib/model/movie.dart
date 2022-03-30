import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mysql.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var db = new Mysql();
  var mail = '';

  

  Future<void> main() async {
    final client = RetryClient(http.Client());
    try {
      final res =await http.get(Uri.parse('http://10.0.2.2:3001/home'));
      print(jsonDecode(res.body)['err']);
      print(jsonDecode(res.body)['data']);
      mail = await client.read(Uri.parse('http://10.0.2.2:3001/home'));
      // print(mail);
    } finally {
      client.close();
    }
  }


  void _incrementCounter() {
    main();
    _counter = _counter + 1;
    print(_counter);
    db.getConnection().then((conn) {
      String sql = 'SELECT * from csn_database.user;';
      conn.query(sql).then((results){
        for(var row in results){
          print('user_id : ${row[0]}');
          setState(() {
            mail = row[0];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
