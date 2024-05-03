import 'package:flutter/material.dart';
import 'package:chocobi/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      theme: ThemeData(fontFamily: 'Open Sans'),
      home: const SplashScreen(),
    );
  }
}