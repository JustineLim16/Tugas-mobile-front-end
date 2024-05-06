// sebelumnya: signup.dart
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:chocobi/data/users.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _passwordControl  = TextEditingController();
  String _statusText = '';
  bool _buttonDisabled = false;
  
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
            const Text('Chocobi - Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter new username'
              ),
              controller: _usernameControl,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter registered email'
              ),
              controller: _emailControl,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter new password'
              ),
              obscureText: true,
              controller: _passwordControl,
            ),
            const SizedBox(height: 20),
            Text(_statusText, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _buttonDisabled ? null : () {
          if (_usernameControl.text.isNotEmpty
              && _emailControl.text.isNotEmpty
              && _passwordControl.text.isNotEmpty) {
                if (users.any((key) => key['email'] == _emailControl.text)) {
                    setState(() {
                      _statusText = 'Email already registered, try a different one';
                    }
                  );
                } else {
                  users.addAll(
                    [{
                      "username": _usernameControl.text,
                      "email": _emailControl.text,
                      "password": _passwordControl.text,
                      "profile" : "https://i.pinimg.com/736x/88/08/6b/88086b5e12f8a2146ea48e37070819fa.jpg"
                    }]
                  );
                  setState(() {
                    _statusText = 'User registered, log in to start using Chocobi';
                    _buttonDisabled = true;
                  });
                  Timer(
                    const Duration(seconds: 3), () {
                      Navigator.pop(context, true);
                    },
                  );
                }
              } else {
                setState(() {
                  _statusText = 'Something\'s missing, please try again';
                }
              );
            }
          },
          child: const Text('Register')
        ),
        TextButton(onPressed: _buttonDisabled ? null : () {
            Navigator.pop(context, true);
          },
          child: const Text('Cancel')
        ),
      ],
    );
  }
}
