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
import 'package:chocobi/screens/settings.dart';

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

  List<Map<String, dynamic>> all = [
  {
    "category": "income",
    "description": "Transfer",
    "date": "2024-04-02",
    "price": 500000
  },
  {
    "category": "income",
    "description": "Saving",
    "date": "2024-04-02",
    "price": 2000000
  },
  {
    "category": "expense",
    "description": "Clothes",
    "date": "2024-04-02",
    "price": 1000000
  },
  {
    "category": "expense",
    "description": "Food",
    "date": "2024-04-02",
    "price": 200000
  },
  {
    "category": "expense",
    "description": "Transfer",
    "date": "2024-04-02",
    "price": 1000000
  },
  {
    "category": "income",
    "description": "Transfer",
    "date": "2024-04-02",
    "price": 200000
  },
  {
    "category": "expense",
    "description": "Food",
    "date": "2024-04-01",
    "price": 150000
  },
  {
    "category": "expense",
    "description": "Subscription",
    "date": "2024-04-01",
    "price": 500000
  },
  {
    "category": "expense",
    "description": "Subscription",
    "date": "2024-04-01",
    "price": 1000000
  },
  {
    "category": "income",
    "description": "Salary",
    "date": "2024-04-01",
    "price": 4500000
  },
];

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              // Aksi untuk 'Settings'
            },
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text('Export Data'),
            onTap: () {
              // Aksi untuk 'Export Data'
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
                ModalRoute.withName("/Profile"));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.home, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    ModalRoute.withName("/Profile"));
                }),
                Text('Home',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.swap_horiz, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Transaction()),
                    ModalRoute.withName("/Profile"));
                } ),
                Text('Transaction',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            FloatingActionButton(
  backgroundColor: Color.fromARGB(255, 21, 96, 189),
  child: Icon(Icons.add, color: Colors.white),
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Transaction"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text("Income"),
                            leading: Radio<String>(
                              value: "income",
                              groupValue: _radioValue,
                              onChanged: (String? value) {
                                setState(() => _radioValue = value);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Expense"),
                            leading: Radio<String>(
                              value: "expense",
                              groupValue: _radioValue,
                              onChanged: (String? value) {
                                setState(() => _radioValue = value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Masukkan Judul",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Masukkan Jumlah",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Logic to handle when "ADD" button is pressed
              },
              child: Text("ADD", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog when "CANCEL" button is pressed
              child: Text("CANCEL", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  },
),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.account_balance_wallet, size: 30), onPressed: () {
                  showDialog(context: context, builder: (context){return const TestCard();});
                }),
                Text('Budget',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.person, size: 30, color: Color.fromARGB(255, 17, 80, 156)), onPressed: () {}),
                Text('Profile',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}
