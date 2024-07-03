import 'package:chocobi/screens/budget.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatefulWidget {
  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List light = [Colors.white, Colors.black, Colors.grey[300]];
  List dark = [Colors.black, Colors.white, Colors.grey[800]];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      color: Provider.of<SettingsModel>(context).isDarkMode ? Colors.black : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildBottomAppBarItem(Icons.home, 'Home', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              ModalRoute.withName("/Home"),
            );
          }),
          _buildBottomAppBarItem(Icons.swap_horiz, 'Transaction', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Transaction(income_selected: true, expense_selected: true,)),
              ModalRoute.withName("/Home"),
            );
          }),
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 21, 96, 189),
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddTransactionDialog(context); // Panggil fungsi yang menampilkan dialog
            },
          ),
          _buildBottomAppBarItem(Icons.account_balance_wallet, 'Budget', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Budget()),
              ModalRoute.withName("/Home"),
            );
          }),
          _buildBottomAppBarItem(Icons.person, 'Profile', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
              ModalRoute.withName("/Home"),
            );
          }),
        ],
      ),
    );
  }

  Column _buildBottomAppBarItem(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(icon, size: 30), onPressed: onPressed),
        Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Transaction"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
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
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Judul",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Jumlah",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater than zero';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar and add the transaction
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data')),
                  );
                  Navigator.pop(context); // Close the dialog
                }
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
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  String? _radioValue;
}
