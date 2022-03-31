import 'package:flutter/material.dart';
import 'package:cinema_social_network/screens/signin.dart';
import 'package:mysql_client/mysql_client.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<SignupPage> createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {
    static const routeName = '/next-page';
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailidControler = TextEditingController();
    // TextEditingController temp = TextEditingController();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                //     Image.asset(
                //     "assets/images/bg.jpg",
                //     height: MediaQuery.of(context).size.height,
                //     width: MediaQuery.of(context).size.width,
                //     fit: BoxFit.cover,
                // ),

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
                    style: TextStyle(
                        color: Colors.red),
                    )),
                Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: emailidControler,
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Email ID',
                    ),
                ),
                ),
                Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
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
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                    child: const Text('SignUp'),
                    onPressed: () {
                        print("Button Pressed");
                        var result = widget.pool.execute(
                            "INSERT INTO user (user_id, user_emailid, user_password) VALUES (:id, :eid, :pass);",
                            {
                              "id": nameController.text,
                              "eid": emailidControler.text,
                              "pass":passwordController.text
                            });

                        result.then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SigninPage(pool: widget.pool)),
                            );
                        });
                    },
                    )
                ),
                Row(
                children: <Widget>[
                    const Text('Already have an account'),
                    TextButton(
                    child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                        
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage(pool: widget.pool)),
                        );
                        //signin screen
                    },
                    )
                ],),
            ],
            ),);
    }
}