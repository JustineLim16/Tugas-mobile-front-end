import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chocobi/screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    movingToNextScreen();
  }

  void movingToNextScreen() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Welcome(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          color: Color.fromARGB(255, 17, 80, 156),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.savings_rounded,
                color: Colors.white,
                size: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Chocobi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
