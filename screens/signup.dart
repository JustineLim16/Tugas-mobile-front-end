import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chocobi/screens/profile.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  var status = "";
  var buttonDisabled = false;

  String? _radioValue = "";
  
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
    email.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sign up to Chocobi"),
      actions: [
        TextButton(onPressed: buttonDisabled ? null : () {
          if (username.text.length >= 8 && password.text.length >= 8 && email.text.contains("@")) {
            setState((){
              status = "User ${username.text} registered, you are being redirected..";
              buttonDisabled = true;
            });
            movingToNextScreen();
          }
          else {
            setState(() {
              status = "Something's wrong. Please try again.";
            });
          } 
        }, child: const Text("Sign up", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
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
              hintText: "Enter email",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            controller: email,
            onChanged: (value) {
              if (!email.text.contains("@")) {
                setState(() {
                  status = "This is not an email.";
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
              hintText: "Enter new username",
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
              hintText: "Enter new password",
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
            height: 20,
          ),
          Text('User Type'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Text("Normal"),
                  leading: Radio<String>(
                    value: "normal",
                    groupValue: _radioValue,
                    onChanged: (String? value) {
                      setState(() => _radioValue = value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text("Admin"),
                  leading: Radio<String>(
                    value: "admin",
                    groupValue: _radioValue,
                    onChanged: (String? value) {
                      setState(() => _radioValue = value);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Text(status)],
        ),
      ),
    );
  }
}