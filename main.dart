import 'package:chocobi/data/account_data.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:chocobi/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        ChangeNotifierProvider(create: (context) => SettingsModel())
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chocobi',
      theme: Provider.of<SettingsModel>(context).isDarkMode  ? ThemeData.dark()  : ThemeData.light(),
      home:  SplashScreen()
    );
  }
}
