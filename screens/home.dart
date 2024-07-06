import 'dart:ui';
import 'package:chocobi/data/account_data.dart';
import 'package:chocobi/screens/button_nav.dart';
import 'package:chocobi/screens/clock.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  List light = [Colors.white, Colors.black, Colors.grey[300]];
  List dark = [Colors.black, Colors.white, Colors.grey[800]];
  num totalIncome = 0;
  num totalExpense = 0;
  
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 17, 80, 156),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClockWidget(),
                          Text("Hello, ${Provider.of<ProfileNotifier>(context).accountInfo["name"]}", style: TextStyle(fontSize: 13, color: Colors.white)),
                          Text("Welcome Back", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                            ModalRoute.withName("/Home"),
                          );
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: 
                            Provider.of<ProfileNotifier>(context).accountInfo["picStatus"] == "asset" 
                            ? AssetImage(Provider.of<ProfileNotifier>(context).accountInfo["profilePic"])
                            : NetworkImage(Provider.of<ProfileNotifier>(context).accountInfo["profilePic"]) as ImageProvider,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Provider.of<SettingsModel>(context).isDarkMode ? dark[0] : light[0],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(3, 10),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Text("Account Balance", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
                          Text(
                            "Rp ${formatNumberWithThousandSeparator(totalIncome - totalExpense)}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.85,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Provider.of<SettingsModel>(context).isDarkMode ? dark[0] : light[0],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Recent Incomes", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => Transaction(income_selected: true, expense_selected: false)),
                                            ModalRoute.withName("/Home"),
                                          );
                                        },
                                        child: Text("View All", style: TextStyle(color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1])),
                                      ),
                                    ],
                                  ),
                                  ...income.take(2).map((e) {
                                    return Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          color: Provider.of<SettingsModel>(context).isDarkMode ? dark[2] : light[2],
                                          child: Container(
                                            height: MediaQuery.of(context).size.height / 16,
                                            child: ListTile(
                                              leading: Icon(Icons.arrow_drop_down, size: 50, color: Colors.green),
                                              title: Text(
                                                "Rp ${formatNumberWithThousandSeparator(e['price'])}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1],
                                                ),
                                              ),
                                              trailing: Text(
                                                "${e["description"]}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Recent Expenses", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => Transaction(income_selected: false, expense_selected: true)),
                                            ModalRoute.withName("/Home"),
                                          );
                                        },
                                        child: Text("View All", style: TextStyle(color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1])),
                                      ),
                                    ],
                                  ),
                                  ...expense.take(2).map((e) {
                                    return Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          color: Provider.of<SettingsModel>(context).isDarkMode ? dark[2] : light[2],
                                          child: Container(
                                            height: MediaQuery.of(context).size.height / 17,
                                            child: ListTile(
                                              leading: Icon(Icons.arrow_drop_down, size: 50, color: Colors.red),
                                              title: Text(
                                                "Rp ${formatNumberWithThousandSeparator(e['price'])}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1],
                                                ),
                                              ),
                                              trailing: Text(
                                                "${e["description"]}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 25,
                  right: 25,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Provider.of<SettingsModel>(context).isDarkMode ? Colors.black.withOpacity(1) : light[0],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Provider.of<SettingsModel>(context).isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 1),
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Provider.of<SettingsModel>(context).isDarkMode ? dark[2] : light[2],
                                  child: Icon(Icons.arrow_drop_up, size: 55, color: Colors.green)
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Incomes", style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold)),
                                    Text("${formatNumberWithThousandSeparator(totalIncome)}", style: TextStyle(fontSize: 15))
                                  ],
                                )
                              ],
                            )
                          ),
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Provider.of<SettingsModel>(context).isDarkMode ? dark[2] : light[2],
                                  child: Icon(Icons.arrow_drop_down, size: 55, color: Colors.red)
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Expenses", style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold)),
                                    Text("${formatNumberWithThousandSeparator(totalExpense)}", style: TextStyle(fontSize: 15))
                                  ],
                                )
                              ],
                            )
                          ),
                          SizedBox(width: 1)
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      bottomNavigationBar: CustomBottomAppBar()
    );
  }
}
