// import 'package:flutter/material.dart';

// import 'package:cinema_social_network/screens/signup.dart';
import 'package:cinema_social_network/model/movie.dart';
import 'package:cinema_social_network/model/user.dart'  as user_info;
// import 'package:mysql_client/mysql_client.dart';



// class SigninPage extends StatelessWidget {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//             body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                 Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const Text(
//                     'CSN',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 30),
//                     )),
//                 Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                     "",
//                     style: TextStyle(
//                         color: Colors.red),
//                     )),
//                 Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'User Email ID',
//                     ),
//                 ),
//                 ),
//                 Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                     obscureText: true,
//                     controller: passwordController,
//                     decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     ),
//                 ),
//                 ),
//                 TextButton(
//                 onPressed: () {
//                     //forgot password screen
//                 },
//                 child: const Text('Forgot Password',),
//                 ),
//                 Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: ElevatedButton(
//                     child: const Text('Login'),
//                     onPressed: () {
//                       final pool = MySQLConnectionPool(
//                         host: '10.0.2.2',
//                         port: 3306,
//                         userName: 'root',
//                         password: 'Sunny#0145',
//                         maxConnections: 10,
//                         databaseName: 'csn_database', // optional,
//                       );
//                       var result = pool.execute("SELECT * FROM user");
//                       var res = pool.execute(
//                           "SELECT * FROM user ");

//                       res.then((value) {
//                         for (var r in value.rows) {
//                           print(r.assoc()["user_password"]);
//                         }
//                       }
//                       );
//                         print(nameController.text);
//                         print(passwordController.text);
//                     },
//                     )
//                 ),
//                 Row(
//                 children: <Widget>[
//                     const Text('Does not have account?'),
//                     TextButton(
//                     child: const Text(
//                         'Sign up',
//                         style: TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                         Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
//                         );
//                         //signup screen
//                     },
//                     )
//                 ],),
//             ],
//             ),);
//     }
// }

import 'package:flutter/material.dart';

import 'package:cinema_social_network/screens/signup.dart';
import 'package:mysql_client/mysql_client.dart';

// class UserInfo {
//   static late int id;
//   UserInfo(int id) {
//     this.id = id;
//   }
//   getId() {
//     return this.id;
//   }
// }

// class SigninPage extends StatelessWidget {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final int
//       Id; // <--- generates the error, "Field doesn't override an inherited getter or setter"
//   SigninPage({required int Id}) : this.Id = Id;

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'CSN',
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 30),
//               )),
//           Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 "",
//                 style: TextStyle(color: Colors.red),
//               )),
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'User Email ID',
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//             child: TextField(
//               obscureText: true,
//               controller: passwordController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               //forgot password screen
//             },
//             child: const Text(
//               'Forgot Password',
//             ),
//           ),
//           Container(
//               height: 50,
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: ElevatedButton(
//                 child: const Text('Login'),
//                 onPressed: () {},
//               )),
//           Row(
//             children: <Widget>[
//               const Text('Does not have account?'),
//               TextButton(
//                 child: const Text(
//                   'Sign up',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignupPage()),
//                   );
//                   //signup screen
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'CSN',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "",
                style: TextStyle(color: Colors.red),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Email ID',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //forgot password screen
              print(user_info.globalSessionData.userId);
            },
            child: const Text(
              'Forgot Password',
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  print("Button Pressed");
                  var result = widget.pool.execute(
                      "SELECT * FROM user as u where u.user_emailid = :rollno AND u.user_password = :name ",
                      {
                        "rollno": nameController.text,
                        "name": passwordController.text
                      });

                  result.then((value) {
                    for (var r in value.rows) {
                      print(r.assoc());
                    }
                    if (value.rows.isNotEmpty) {
                      for(var r in value.rows){
                        user_info.globalSessionData.userId = r.assoc()["user_id"]!;
                        user_info.globalSessionData.email = r.assoc()["user_emailid"]!;
                        user_info.globalSessionData.admin = int.parse(r.assoc()["user_type"]!);
                      }
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(pool: widget.pool)),
                      );
                      
                    }
                  });
                },
              )),
          Row(
            children: <Widget>[
              const Text('Does not have account?'),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage(pool: widget.pool)),
                  );
                  // signup screen
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

