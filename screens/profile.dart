import 'dart:ui';
import 'package:chocobi/screens/welcome.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';

import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:chocobi/screens/export.dart';
import 'package:chocobi/screens/button_nav.dart';

class Profile extends StatefulWidget {
  Profile ({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  num totalIncome = 0;
  num totalExpense = 0;

  String? _radioValue = "";


  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    for (var item in income) {
      totalIncome += item['price'];
    }
    for (var item in expense) {
      totalExpense += item['price'];
    }
  }

  String formatNumberWithThousandSeparator(num number) {
    final formatter = NumberFormat('#,##0', 'id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Color.fromARGB(255, 17, 80, 156),
            height: MediaQuery.of(context).size.height/4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 51,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('lib/assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Shinchan", style: TextStyle(fontSize: 22, color: Colors.white)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit_rounded, color: Colors.white, size: 18,))
                        ],
                      ),
                      Text("shinchan@gmail.com", style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                      Text("08116075384", style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                    ],
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account'),
            onTap: () {
              // Aksi untuk 'Account'
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Aksi untuk 'Settings'
            },
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text('Export Data'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExportSuccessPage()),
              );

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
