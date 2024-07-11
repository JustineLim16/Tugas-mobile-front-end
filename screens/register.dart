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
  final _phoneControl  = TextEditingController();
  final _verificationControl = TextEditingController();

  String _statusText = '';
  bool _widgetDisabled = false;

  final PageController _progressController = PageController(initialPage: 0);
  
  double _progressPage = 0;
  int _currentPage = 0;
  
  @override
  void initState() {
    super.initState();
    _progressPage = 1/2; 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: SizedBox(
        width: double.infinity,
        child: LinearProgressIndicator( ///
          value: _progressPage,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: PageView(
          controller: _progressController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            setState(
              () {
                _currentPage = page;
                _progressPage = (_currentPage + 1) / 2;
              }
            );
          },
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                const Text('Chocobi - Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Username",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    hintText: 'Enter new username'
                  ),
                  controller: _usernameControl,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    hintText: 'Enter registered email'
                  ),
                  controller: _emailControl,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    hintText: 'Enter registered phone number'
                  ),
                  controller: _phoneControl,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    hintText: 'Enter new password'
                  ),
                  obscureText: true,
                  controller: _passwordControl,
                ),
                const SizedBox(height: 20),
                Text(
                  _statusText, style: const TextStyle(fontSize: 14)
                ),
                const SizedBox(height: 20),
                TextButton(onPressed: _widgetDisabled ? null : () {
                  if (_usernameControl.text.isNotEmpty
                      && _emailControl.text.isNotEmpty
                      && _passwordControl.text.isNotEmpty
                      && _phoneControl.text.isNotEmpty) {
                        if (users.any((key) => key['email'] == _emailControl.text)) {
                            setState(() {
                              _statusText = 'Email already registered, try a different one';
                            }
                          );
                        } else {
                          setState(
                            () {
                              _statusText = '';
                            }
                          );
                          _progressController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn
                          );
                        }
                      } else {
                        setState(() {
                          _statusText = 'Something\'s missing, please try again';
                        }
                      );
                    }
                  },
                  child: const Text('Next')
                ),
                TextButton(onPressed: _widgetDisabled ? null : () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Cancel')
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                const Text('Chocobi - Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 128,
                    ),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Enter the OTP sent to ${_phoneControl.text}'
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter 230624'
                      ),
                      readOnly: _widgetDisabled,
                      controller: _verificationControl,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _statusText, style: const TextStyle(fontSize: 14)
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
                TextButton(
                  onPressed: _widgetDisabled ? null : () {
                    if (_verificationControl.text == '230624') {
                      users.addAll(
                        [{
                          "username": _usernameControl.text,
                          "email": _emailControl.text,
                          "password": _passwordControl.text,
                          "phone" : _phoneControl.text,
                          "profile" : "https://i.pinimg.com/736x/88/08/6b/88086b5e12f8a2146ea48e37070819fa.jpg"
                        }]
                      );
                      setState(() {
                        _statusText = 'User registered, log in to start using Chocobi';
                        _widgetDisabled = true;
                      });
                      Timer(
                        const Duration(seconds: 3), () {
                          Navigator.pop(context, true);
                        },
                      );
                    } else {
                      setState(
                        () {
                          _statusText = 'Incorrect OTP, please try again';
                        }
                      );
                    }
                  },
                  child: const Text('Verify')
                ),
                TextButton(
                  onPressed: _widgetDisabled ? null : () {
                    setState(
                      () {
                        _statusText = '';
                      }
                    );
                    _progressController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn
                    );
                  },
                  child: const Text('Back')
                ),
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              ]
            ),
          ],
        )
      )
    );
  }
}
