import 'package:chocobi/data/money.dart';
import 'package:chocobi/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting
import 'package:flutter/services.dart'; // Import flutter services
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});

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
              showDialog(
                context: context,
                builder: (BuildContext context) => AddTransactionDialog(),
              );
            },
          ),
          _buildBottomAppBarItem(Icons.account_balance_wallet, 'Account', () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
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
}

class AddTransactionDialog extends StatefulWidget {
  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  String? _radioValue;
  Map<String, dynamic> addData = {
    "category": "",
    "description": "",
    "date": DateTime.now(),
    "price": 0
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Transaction"),
      content: SingleChildScrollView(
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
                        setState(() {
                          _radioValue = value;
                          addData["category"] = "income";
                        });
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
                        setState(() {
                          _radioValue = value;
                          addData["category"] = "expense";
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Enter Description",
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
                hintText: "Enter Amount",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly // Only allow digits
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (int.parse(value) <= 0) {
                  return 'Please enter a number greater than zero';
                }
                return null;
              },
            ),
            ListTile(
              title: Text("Select Date"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                _selectDateTime(context); // Call function to select date
              },
            ),
            // Display selected date
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Selected Date:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text("CANCEL"),
        ),
        TextButton(
          onPressed: () {
            if (_titleController.text.isEmpty || _amountController.text.isEmpty || _radioValue == null || _selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all fields')),
              );
            } else {
              setState(() {
                addData["description"] = _titleController.text;
                addData["price"] = int.parse(_amountController.text);
                addData["date"] = _selectedDate;
              });
              context.read<MoneyNotifier>().updateMoney(addData);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Processing Data')),
              );
              Navigator.pop(context); // Close the dialog
            }
          },
          child: Text("ADD"),
        ),
      ],
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? selectedDate;

    setState(() {
      _selectedDate = selectedDate; // Update selected date
      addData["date"] = selectedDate;
    });
  }
}
