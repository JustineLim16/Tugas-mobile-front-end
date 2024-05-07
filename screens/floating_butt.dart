import 'package:flutter/material.dart';
import '';


class CustomFloatingActionButton extends StatefulWidget {
  @override
  _CustomFloatingActionButtonState createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  String? _radioValue = "";

  void _showAddTransactionDialog(BuildContext context) {
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
