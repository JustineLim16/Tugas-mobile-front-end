import 'package:chocobi/screens/button_nav.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Transaction extends StatefulWidget {
  Transaction({super.key, required this.income_selected, required this.expense_selected});
  final bool income_selected;
  final bool expense_selected;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List light = [Colors.white, Colors.black, Colors.grey[300], const Color.fromARGB(255, 17, 80, 156)];
  List dark = [Colors.black, Colors.white, Colors.grey[800], const Color.fromARGB(255, 12, 55, 108)];

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

  void deleteItem(int position) {
  var item = filteredData()[position];
  all.remove(item);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Item deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            all.insert(position, item);
          });
        },
      ),
    ),
  );

  setState(() {});
}

  @override
  void initState() {
    super.initState();
    history[0]["_selected"] = widget.income_selected;
    history[1]["_selected"] = widget.expense_selected;
  }

  String formatNumberWithThousandSeparator(num number) {
    final formatter = NumberFormat('#,##0', 'id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156), 
        title: Text(
          "Transaction History", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  FilterChip(
                    selectedColor: Color.fromARGB(255, 17, 80, 156),
                    checkmarkColor: Colors.white,
                    selected: history[0]["_selected"],
                    label: Text(
                      "Income",
                      style: TextStyle(
                        color: history[0]["_selected"] ? Colors.white : Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1]),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        history[0]["_selected"] = !history[0]["_selected"];
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  FilterChip(
                    selectedColor: Color.fromARGB(255, 17, 80, 156),
                    checkmarkColor: Colors.white,
                    selected: history[1]["_selected"],
                    label: Text(
                      "Expense",
                      style: TextStyle(
                        color: history[1]["_selected"] ? Colors.white : Provider.of<SettingsModel>(context).isDarkMode ? dark[1] : light[1]),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        history[1]["_selected"] = !history[1]["_selected"];
                      });
                    },
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Divider(),
              Row(
                children: [
                  DropdownMenu(
                    label: Text("Month"),
                    dropdownMenuEntries: month.map((e) => 
                      DropdownMenuEntry(
                        value: e, label: e
                      )
                    ).toList(),
                    onSelected: (newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                      print(selectedMonth);
                    });
                  },
                  ),
                  SizedBox(width: 20),
                  DropdownMenu(
                    label: Text("Year"),
                    dropdownMenuEntries: year.map((e) => 
                      DropdownMenuEntry(
                        value: e, label: e
                      )
                    ).toList(),
                    onSelected: (newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData().length,
                  itemBuilder: (context, position) {
                    if ((history[0]["_selected"] &&
                            filteredData()[position]["category"] == "income") ||
                        (history[1]["_selected"] &&
                            filteredData()[position]["category"] == "expense")) {
                      IconData iconData = filteredData()[position]["category"] == "income"
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down;
                      Color iconColor = filteredData()[position]["category"] == "income"
                          ? Colors.green
                          : Colors.red;

                      return Column(
                        children: [
                          Slidable(
                            actionExtentRatio: 0.3,
                            key: Key(filteredData()[position].toString()),
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  deleteItem(position);
                                },
                                closeOnTap: true,
                              ),
                            ],
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
                                        "${DateFormat('yyyy-MM-dd').format(filteredData()[position]['date'])}",
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${filteredData()[position]['description']}",
                                        style: TextStyle(
                                            color: iconColor, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 130,
                                          child: Text(
                                            "Rp ${formatNumberWithThousandSeparator(all[position]['price'])}",
                                            style: TextStyle(
                                                color: iconColor, fontSize: 18),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Icon(iconData, color: iconColor, size: 40)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(), 
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar()
    );
  }
}

