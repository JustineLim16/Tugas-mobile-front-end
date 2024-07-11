import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:chocobi/data/money.dart';
import 'package:chocobi/data/credits.dart';

import 'package:chocobi/screens/button_nav.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String formatNumberWithThousandSeparator(num number) {
    final formatter = NumberFormat('#,##0', 'id');
    return formatter.format(number);
  }

  int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 33,
            child: Container(
              color: const Color.fromARGB(255, 17, 80, 156),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider.builder(
                  itemCount: credits.length,
                  itemBuilder: (context, index, realIndex) => 
                    SizedBox(
                      width: 256.0,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.credit_card),
                                  const SizedBox(width: 12.0),
                                  Text(credits[index]['bank'])
                                ], 
                              ),
                              const SizedBox(height: 28.0),
                              Text(credits[index]['number']),
                              Text(credits[index]['expired']),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(credits[index]['name']),
                                  const SizedBox(
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
                  options: CarouselOptions(
                    onPageChanged : (index, reason) {
                      setState(
                        () {
                          currentCard = index;
                        }
                      );
                    }, 
                  )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 24,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh)
                      )
                    ],
                  ),
                  const Divider(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Account Status'),
                              Text(
                                credits[currentCard]['status'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Due Date'),
                              Text(
                                credits[currentCard]['due'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Current Balance'),
                              Text(
                                '\$ ${
                                  credits[currentCard]['balance']
                                }',
                                style: const TextStyle(
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
            flex: 33,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                        itemCount: Provider.of<MoneyNotifier>(context).all.length,
                        itemBuilder: (context, position) {
                          if (
                            (
                              Provider.of<MoneyNotifier>(context).all[position]["category"] == "income"
                            ) ||
                            (
                              Provider.of<MoneyNotifier>(context).all[position]["category"] == "expense"
                            )
                          ) {
                            IconData iconData = Provider.of<MoneyNotifier>(context).all[position]["category"]
                            == "income"
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down;
                            Color iconColor = Provider.of<MoneyNotifier>(context).all[position]["category"]
                            == "income"
                                ? Colors.green
                                : Colors.red;

                            return Column(
                              children: [
                                Slidable(
                                  actionExtentRatio: 0.3,
                                  key: Key(
                                    Provider.of<MoneyNotifier>(context).all[position].toString()
                                  ),
                                  actionPane: const SlidableDrawerActionPane(),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height / 15,
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
                                                  Provider.of<MoneyNotifier>(context).all[position]['date']
                                                ),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              "${
                                                Provider.of<MoneyNotifier>(context).all[position]['description']
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
                                                    Provider.of<MoneyNotifier>(context).all[position]['price']
                                                  )
                                                }",
                                                style: TextStyle(
                                                  color: iconColor,
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
            showDialog(
              context: context, builder: (BuildContext context) {
                final numberControl = TextEditingController();
                final nameControl = TextEditingController();
                final expirationControl  = TextEditingController();
                
                String selectedBank = 'CIMB Niaga';
                String statusText = '';
                DateTime? dueDate;

                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    Future<void> selectDateTime(BuildContext context) async {
                      DateTime selectedDate = DateTime.now();

                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      ) ?? selectedDate;
                    
                      setState(
                        () {
                          dueDate = selectedDate;
                        }
                      );
                    }
                    return AlertDialog(
                      alignment: Alignment.center,
                      content: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add Credit Card',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            const SizedBox(height: 30),
                            const Text('Bank Name'),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedBank,
                              onChanged: (newValue) {
                                setState(
                                  () {
                                    selectedBank = newValue!;
                                  }
                                );
                              },
                              items: <String>['CIMB Niaga', 'BCA', 'BRI', 'Mandiri']
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                              ).toList(),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: "Credit Card Number",
                                hintText: '0000-0000-0000-0000',
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(),
                              ),
                              maxLength: 19,
                              controller: numberControl,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: "Expiration Date",
                                hintText: 'MM/YY',
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(),
                              ),
                              maxLength: 5,
                              controller: expirationControl,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: "Cardholder's Name",
                                hintText: 'e.g. SAMSUDIN',
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(),
                              ),
                              controller: nameControl,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Due Date'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (dueDate != null)
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(dueDate!)
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            selectDateTime(context);
                                          }
                                        );
                                      },
                                      icon: const Icon(Icons.calendar_month_outlined)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(statusText, style: const TextStyle(fontSize: 14)),
                          ],
                        )
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (numberControl.text.length == 19
                                && numberControl.text.contains('-')
                                && expirationControl.text.length == 5
                                && expirationControl.text.contains('/')
                                && nameControl.text.isNotEmpty
                                && dueDate != null) {
                              
                              if(credits.any((key) => key['number'] == numberControl.text)) {
                                setState(
                                  () {
                                    statusText = 'Number already registered, try a different one';
                                  }
                                );
                              }
                              else {
                                credits.addAll(
                                  [{
                                    "bank": selectedBank,
                                    "number": numberControl.text,
                                    "expired": expirationControl.text,
                                    "name" : nameControl.text,
                                    "status" : "Active",
                                    "due" : DateFormat('dd-MM-yyyy').format(dueDate!).toString(),
                                    "balance" : 500
                                  }]
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Credit Card Added')
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            }
                            else {
                              setState(
                                () {
                                  statusText = 'Something\'s missing, please try again';
                                }
                              );
                            }
                          },
                          child: const Text('Add')
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Cancel')
                        ),
                      ],
                    );
                  }
                );
              },
            );
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const CustomBottomAppBar()
    );
  }
}