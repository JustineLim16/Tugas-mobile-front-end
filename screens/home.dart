import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:chocobi/screens/transaction.dart';

class Home extends StatefulWidget {
  Home ({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
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
                            Text("Hello, Shinchan", style: TextStyle(fontSize: 13, color: Colors.white)),
                            Text("Welcome Back", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,MaterialPageRoute(builder: (context) => Profile()),
                              ModalRoute.withName("/Home"));
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('lib/assets/profile.jpg'),
                            radius: 35,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder()
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity, 
                      height: 100, 
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                            Text("Rp ${formatNumberWithThousandSeparator(totalIncome-totalExpense)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.85,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 249, 249),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
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
                                      TextButton(onPressed: (){
                                        showDialog(context: context, builder: (context){return const TestCard();});
                                      }, child: Text("View All", style: TextStyle(color: Colors.black)))
                                    ],
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    height: MediaQuery.of(context).size.height/17,
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_drop_up, size: 50, color: Colors.green),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Rp ${formatNumberWithThousandSeparator(income[0]['price'])}", style: TextStyle(fontSize: 17)),
                                              Text("${income[0]["description"]}", style: TextStyle(fontSize: 15, color: Colors.grey[600]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    color: Colors.grey[200],
                                    height: MediaQuery.of(context).size.height/17,
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_drop_up, size: 50, color: Colors.green),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Rp ${formatNumberWithThousandSeparator(income[1]['price'])}", style: TextStyle(fontSize: 17)),
                                              Text("${income[1]["description"]}", style: TextStyle(fontSize: 15, color: Colors.grey[600]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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
                                      TextButton(onPressed: (){
                                        showDialog(context: context, builder: (context){return const TestCard();});
                                      }, child: Text("View All", style: TextStyle(color: Colors.black)))
                                    ],
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    height: MediaQuery.of(context).size.height/17,
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_drop_down, size: 50, color: Colors.red),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Rp ${formatNumberWithThousandSeparator(expense[0]['price'])}", style: TextStyle(fontSize: 17)),
                                              Text("${expense[0]["description"]}", style: TextStyle(fontSize: 15, color: Colors.grey[600]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    color: Colors.grey[200],
                                    height: MediaQuery.of(context).size.height/17,
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_drop_down, size: 50, color: Colors.red),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Rp ${formatNumberWithThousandSeparator(expense[1]['price'])}", style: TextStyle(fontSize: 17)),
                                              Text("${expense[1]["description"]}", style: TextStyle(fontSize: 15, color: Colors.grey[600]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                        ),
                      )
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            color: Colors.black.withOpacity(0.3),
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
                                  backgroundColor: Colors.grey[300],
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
                                  backgroundColor: Colors.grey[300],
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
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.home, size: 30, color: Color.fromARGB(255, 17, 80, 156)), onPressed: () {}),
                Text('Home',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.swap_horiz, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Transaction()),
                    ModalRoute.withName("/Home"));
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
                IconButton(icon: Icon(Icons.person, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                    ModalRoute.withName("/Home"));
                }),
                Text('Profile',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      )
    );
  }
}
