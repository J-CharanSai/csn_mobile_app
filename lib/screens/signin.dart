import 'package:flutter/material.dart';

import 'package:cinema_social_network/screens/signup.dart';
import 'package:cinema_social_network/model/movie.dart';



class SigninPage extends StatelessWidget {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    @override
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
                    style: TextStyle(
                        color: Colors.red),
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
                },
                child: const Text('Forgot Password',),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                    },
                    )
                ),
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
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
                        );
                        //signup screen
                    },
                    )
                ],),
            ],
            ),);
    }
}