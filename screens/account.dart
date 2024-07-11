import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
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
  final _usernameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _passwordControl  = TextEditingController();
  final _phoneControl  = TextEditingController();
  final _verificationControl = TextEditingController();

  String _statusText = '';
  bool _widgetDisabled = false;


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
                  itemCount: 3,
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
                  const Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
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
              context: context, builder: (context) {
                return AlertDialog(
                  alignment: Alignment.center,
                  content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Chocobi - Log In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(),
                        ),
                        readOnly: _widgetDisabled,
                        controller: _usernameControl,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        readOnly: _widgetDisabled,
                        controller: _passwordControl,
                      ),
                      const SizedBox(height: 15),
                      TextButton(onPressed: _widgetDisabled ? null : () {
                          //-- page untuk ganti password, autentikasi dsb.
                        },
                        child: const Text('Forgot password?'),
                      ),
                      const SizedBox(height: 20),
                      Text(_statusText, style: const TextStyle(fontSize: 14)),
                      ],
                    )
                  ),
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