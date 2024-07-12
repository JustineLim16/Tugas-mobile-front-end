// sebelumnya: signup.dart
import 'dart:async';
import 'package:chocobi/data/account_data.dart';
import 'package:flutter/material.dart';

import 'package:chocobi/data/users.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameControl = TextEditingController();
  final _passwordControl  = TextEditingController();
  String _statusText = '';
  bool _widgetDisabled = false;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chocobi - Log In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter username'
              ),
              readOnly: _widgetDisabled,
              controller: _usernameControl,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter password'
              ),
              obscureText: true,
              readOnly: _widgetDisabled,
              controller: _passwordControl,
            ),
            const SizedBox(height: 20),
            Text(_statusText, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _widgetDisabled ? null : () {
          if (users.any((key) => key['username'] == _usernameControl.text
              && key['password'] == _passwordControl.text)) {
                setState(() {
                  _widgetDisabled = true;
                  context.read<ProfileNotifier>().updateProfileData("name", _usernameControl.text);
                  String email = users[users.indexWhere((element) => element["username"] == _usernameControl.text && element["password"] == _passwordControl.text)]["email"];
                  context.read<ProfileNotifier>().updateProfileData("email", email);
                  String phone = users[users.indexWhere((element) => element["username"] == _usernameControl.text && element["password"] == _passwordControl.text)]["phone"];
                  context.read<ProfileNotifier>().updateProfileData("phone", phone);
                  _statusText = 'Welcome back, you are being redirected..';
                  _widgetDisabled = true;
                });
                Timer(
                  const Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                );
              } else {
                setState(() {
                  _statusText = 'Something\'s wrong, please try again';
                }
              );
            }
          },
          child: const Text('Log In')
        ),
        TextButton(onPressed: _widgetDisabled ? null : () {
            Navigator.pop(context, true);
          },
          child: const Text('Cancel')
        ),
      ],
    );
  }
}
