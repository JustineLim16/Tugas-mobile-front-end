import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:chocobi/data/money.dart';

import 'package:chocobi/screens/buttonnav.dart';
import 'package:chocobi/screens/clock.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:chocobi/screens/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List light = [Colors.white, Colors.black, Colors.grey[300]];
  List dark = [Colors.black, Colors.white, Colors.grey[800]];
  num totalIncome = 0;
  num totalExpense = 0;

  //String? _radioValue = "";

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
      backgroundColor: const Color.fromARGB(255, 17, 80, 156),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 80, 156),
        leading: Builder( ///
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }, 
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClockWidget(),
                          Text(
                            "Hello, Shinchan",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,MaterialPageRoute(
                              builder: (context) => const Profile()
                            ),
                            ModalRoute.withName("/Home"));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder()
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/profile.jpg'),
                          radius: 35,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity, 
                    height: 100, 
                    decoration: BoxDecoration(
                      color: Provider.of<SettingsModel>(context).isDarkMode ? dark[0] : light[0],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(3, 10),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          const Text(
                            "Account Balance",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15
                            ),
                          ),
                          Text(
                            "Rp ${formatNumberWithThousandSeparator(totalIncome-totalExpense)}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/1.85,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Provider.of<SettingsModel>(context)
                      .isDarkMode ? dark[0] : light[0],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Recent Incomes",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    TextButton(
                                      onPressed: () {///
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Function to be implemented')
                                          ),
                                        );
                                      },
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Transaction(
                                                income_selected: true,
                                                expense_selected: false,
                                              ),
                                            ),
                                            ModalRoute.withName("/Home")
                                          );
                                        },
                                        child: Text(
                                          "View All",
                                          style: TextStyle(
                                            color: Provider.of<SettingsModel>(context)
                                            .isDarkMode ? dark[1] : light[1]
                                          )
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                                ...income.take(2).map(
                                  (e) {
                                    return Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Provider.of<SettingsModel>(context)
                                            .isDarkMode ? dark[2] : light[2],
                                          ),
                                          height: MediaQuery.of(context).size.height/17,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.arrow_drop_up,
                                                size: 50,
                                                color: Colors.green
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/1.5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Rp ${formatNumberWithThousandSeparator(e['price'])}",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Provider.of<SettingsModel>(context)
                                                        .isDarkMode ? dark[1] : light[1]
                                                      ),
                                                    ),
                                                    Text(
                                                      "${e["description"]}",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Provider.of<SettingsModel>(context)
                                                        .isDarkMode ? dark[1] : Colors.grey[600]
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    );
                                  }
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Recent Expenses",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {///
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Function to be implemented')
                                          ),
                                        );
                                      },
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Transaction(
                                                income_selected: false,
                                                expense_selected: true,
                                              ),
                                            ),
                                          ModalRoute.withName("/Home")
                                          );
                                        },
                                        child: Text(
                                          "View All",
                                          style: TextStyle(
                                            color: Provider.of<SettingsModel>(context)
                                            .isDarkMode ? dark[1] : light[1]
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...expense.take(2).map((e) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Provider.of<SettingsModel>(context)
                                          .isDarkMode ? dark[2] : light[2],
                                        ),
                                        height: MediaQuery.of(context).size.height/17,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              size: 50,
                                              color: Colors.red
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/1.5,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp ${formatNumberWithThousandSeparator(e['price'])}",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Provider.of<SettingsModel>(context)
                                                      .isDarkMode ? dark[1] : light[1]),
                                                    ),
                                                  Text(
                                                    "${e["description"]}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Provider.of<SettingsModel>(context)
                                                      .isDarkMode ? dark[1] : Colors.grey[600]
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    );
                                  }
                                ),
                              ],
                            )
                          ]
                        ),
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
                      color: Provider.of<SettingsModel>(context)
                      .isDarkMode ? Colors.black.withOpacity(1) : light[0],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                          color: Provider.of<SettingsModel>(context)
                          .isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 1),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 2.6,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Provider.of<SettingsModel>(context)
                                .isDarkMode ? dark[2] : light[2],
                                child: const Icon(
                                  Icons.arrow_drop_up,
                                  size: 55,
                                  color: Colors.green
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Incomes",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    formatNumberWithThousandSeparator(totalIncome),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 2.6,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Provider.of<SettingsModel>(context)
                                .isDarkMode ? dark[2] : light[2],
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 55,
                                  color: Colors.red
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Expenses",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    formatNumberWithThousandSeparator(totalExpense),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                        const SizedBox(width: 1)
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      drawer: const CustomDrawer(),
    );
  }
}
