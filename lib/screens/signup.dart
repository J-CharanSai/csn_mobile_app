import 'package:flutter/material.dart';

import 'package:cinema_social_network/screens/signin.dart';


class SignupPage extends StatelessWidget {
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
                        print(emailidControler.text);
                        print(nameController.text);
                        print(passwordController.text);
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
                        MaterialPageRoute(builder: (context) => SigninPage()),
                        );
                        //signin screen
                    },
                    )
                ],),
            ],
            ),);
    }
}