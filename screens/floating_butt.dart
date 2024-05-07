import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  @override
  _CustomFloatingActionButtonState createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  String? _radioValue;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 21, 96, 189),
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () => _showAddTransactionDialog(context),
    );
  }
}
