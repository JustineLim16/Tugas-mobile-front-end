import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chocobi/screens/profile.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  final sampleUser = ['adminkenneth', '1234567.'];
  var status = "";
  var buttonDisabled = false;
  
  void movingToNextScreen() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Log in to Chocobi"),
      actions: [
        TextButton(onPressed: buttonDisabled ? null : () {
          if (sampleUser[0] == username.text && sampleUser[1] == password.text) {
            setState((){
              status = "Hello ${username.text}, you are being redirected..";
              buttonDisabled = true;
            });
            movingToNextScreen();
          }
          else {
            setState(() {
              status = "Something's wrong. Please try again.";
            });
          } 
        }, child: const Text("Log in", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
        TextButton(onPressed: buttonDisabled ? null : () {
          Navigator.pop(context, true);
        }, child: const Text("Cancel", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
      ],
      content: SizedBox(
        height: 400,
        width: 350,
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter username",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            controller: username,
            onChanged: (value) {
              if (username.text.length < 8) {
                setState(() {
                  status = "Username is too short.";
                });
              }
              else {
                setState(() {
                  status = "";
                });
              }
            }
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter password",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            obscureText: true,
            controller: password,
            onChanged: (value) {
              if (password.text.length < 8) {
                setState(() {
                  status = "Password is too short.";
                });
              }
              else {
                setState(() {
                  status = "";
                });
              }
            }
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: buttonDisabled ? null : () {
              
            },
            child: const Text('Forgot password?')
          ),
          const SizedBox(
            height: 80,
          ),
          Text(status)],
        ),
      ),
    );
  }
}