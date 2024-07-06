import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:chocobi/data/money.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List <String> month = ["Month", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  List <String> year = ["Year", "2021", "2022", "2023", "2024"];

  List<Map<String, dynamic>> history = [
    {
      "category": "income",
      "_selected": true
    },
    {
      "category": "expense",
      "_selected": true
    }
  ];

  String selectedMonth = "Month";
  String selectedYear = "Year";

  // Method to filter the data based on selected month and year
  List<Map<String, dynamic>> filteredData() {
    return all.where((item) {
      if (selectedMonth == "Month" && selectedYear == "Year") {
        return true; // No filter applied
      } else {
        final DateTime date = DateTime.parse(item['date']);
        final itemMonth = DateFormat('MMMM').format(date);
        final itemYear = DateFormat('yyyy').format(date);
        if (selectedMonth != "Month" && selectedYear != "Year") {
          return itemMonth == selectedMonth && itemYear == selectedYear;
        }
        if (selectedMonth != "Month" && selectedYear == "Year") {
          return itemMonth == selectedMonth;
        }
        if (selectedMonth == "Month" && selectedYear != "Year") {
          return itemYear == selectedYear;
        }
        return false;
      }
    }).toList();
  }

  String formatNumberWithThousandSeparator(num number) {
    final formatter = NumberFormat('#,##0', 'id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 80, 156),
        title: const Text(
          'Account Card',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 30,
            child: Container(
              color: const Color.fromARGB(255, 17, 80, 156),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder:(context, index, realIndex) => 
                    SizedBox(
                      width: 256.0,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.credit_card),
                                  SizedBox(width: 12.0),
                                  Text('CIMB NIAGA')
                                ], 
                              ),
                              SizedBox(height: 28.0),
                              Text('4284 1688 8888 8888'),
                              Text('07/26'),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('SHINNOSUKE NOHARA'),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle_outlined),
                                        Icon(Icons.circle),
                                      ],
                                    ),
                                  )
                                ], 
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  options: CarouselOptions()
                ),
              ),
            ),
          ),
          Expanded(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Divider(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Account Status'),
                              Text(
                                'Active',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Due Date'),
                              Text(
                                '12-12-2024',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Current Balance'),
                              Text(
                                '\$ 245.23',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
          Expanded(
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: filteredData().length,
                        itemBuilder: (context, position) {
                          if (
                            (
                              history[0]["_selected"] &&
                              filteredData()[position]["category"] == "income"
                            ) ||
                            (
                              history[1]["_selected"] &&
                              filteredData()[position]["category"] == "expense"
                            )
                          ) {
                            IconData iconData = filteredData()[position]["category"]
                            == "income"
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down;
                            Color iconColor = filteredData()[position]["category"]
                            == "income"
                                ? Colors.green
                                : Colors.red;

                            return Column(
                              children: [
                                Slidable(
                                  actionExtentRatio: 0.3,
                                  key: Key(
                                    filteredData()[position].toString()
                                  ),
                                  actionPane: const SlidableDrawerActionPane(),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height / 10,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  filteredData()[position]['date']
                                                ),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              "${
                                                filteredData()[position]['description']
                                              }",
                                              style: TextStyle(
                                                color: iconColor,
                                                fontSize: 15
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                "Rp ${
                                                  formatNumberWithThousandSeparator(
                                                    all[position]['price']
                                                  )
                                                }",
                                                style: TextStyle(
                                                  color: iconColor,
                                                  fontSize: 18
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            Icon(
                                              iconData,
                                              color: iconColor,
                                              size: 40
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(), 
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 48.0,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 17, 80, 156),
          child: const Text(
            'Add New Card',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            )
          ),
          onPressed: () {
        
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}