import 'package:chocobi/screens/account.dart';
import 'package:chocobi/screens/customCircle.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chocobi',
      theme: Provider.of<SettingsModel>(context).isDarkMode  ? ThemeData.dark()  : ThemeData.light(),
      home:  AccountPage(),
    );
  }
}
