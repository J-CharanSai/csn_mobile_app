// import 'package:flutter/material.dart';
// import 'package:cinema_social_network/screens/signin.dart';
// import 'package:cinema_social_network/model/movie.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SigninPage(),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cinema_social_network/screens/signin.dart';
import 'package:mysql_client/mysql_client.dart';

void main() {
  final pool = MySQLConnectionPool(
    host: '10.0.2.2',
    port: 3306,
    userName: 'root',
    password: 'Sunny#0145',
    maxConnections: 10,
    databaseName: 'csn_database', // optional,
  );
  runApp(MyApp(pool: pool));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.pool}) : super(key: key);
  final MySQLConnectionPool pool;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SigninPage(pool: widget.pool),
    );
  }
}
