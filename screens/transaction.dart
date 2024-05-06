import 'package:chocobi/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/data/money.dart';
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transaction extends StatefulWidget {
  Transaction({super.key, required this.income_selected, required this.expense_selected});
  final bool income_selected;
  final bool expense_selected;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List light = [Colors.white, Colors.black, Colors.grey[300]];
  List dark = [Colors.black, Colors.white, Colors.grey[800]];

  List <String> month = ["Month", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  List <String> year = ["Year", "2021", "2022", "2023", "2024"];
  String dropDownValue = "satu";

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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
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
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  DropdownMenu(
                    label: Text("Month"),
                    dropdownMenuEntries: month.map((e) => 
                      DropdownMenuEntry(
                        value: dropDownValue, label: e
                      )
                    ).toList()
                  ),
                  SizedBox(width: 20),
                  DropdownMenu(
                    label: Text("Year"),
                    dropdownMenuEntries: year.map((e) => 
                      DropdownMenuEntry(
                        value: dropDownValue, label: e
                      )
                    ).toList()
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: all.length,
                  itemBuilder: (context, position) {
                    if ((history[0]["_selected"] && all[position]["category"] == "income") ||
                        (history[1]["_selected"] && all[position]["category"] == "expense")) {
                      IconData iconData = all[position]["category"] == "income" ? Icons.arrow_drop_up : Icons.arrow_drop_down;
                      Color iconColor = all[position]["category"] == "income" ? Colors.green : Colors.red;

                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height/10,
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${all[position]['date']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        Text("${all[position]['description']}", style: TextStyle(color: iconColor, fontSize: 18))
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 130,
                                            child: Text("Rp ${formatNumberWithThousandSeparator(all[position]['price'])}", style: TextStyle(color: iconColor, fontSize: 20), textAlign: TextAlign.right)
                                          ),
                                          Icon(iconData, color: iconColor, size: 40)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                          Divider()
                        ],
                      );
                    } 
                    else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: Provider.of<SettingsModel>(context).isDarkMode ? dark[0] : light[0],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.home, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    ModalRoute.withName("/Profile"));
                }),
                Text('Home',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.swap_horiz, color: Color.fromARGB(255, 17, 80, 156), size: 30), onPressed: () {} ),
                Text('Transaction',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 21, 96, 189),
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                showDialog(context: context, builder: (context){
                  return SizedBox(
                    height: 400,
                    child: AlertDialog(
                      title: Text("Add Transaction ?"),
                      actions: [
                        TextButton(onPressed: (){
                          showDialog(context: context, builder: (context){
                            return SizedBox(
                              height: 400,
                              child: AlertDialog(
                                title: Text("Insert Transaction"),
                                actions: [
                                  TextButton(onPressed: (){}, child: Text("ADD", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                                  TextButton(onPressed: (){}, child: Text("CANCEL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                                ],
                                content: SizedBox(
                                  height: 400,
                                  width: 350,
                                  child: Column(children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Judul",
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Jumlah",
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),),
                                    )],),
                                ),
                              ),
                            );
                          });
                        }, child: Text("ADD",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        TextButton(onPressed: (){}, child: Text("CANCEL",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  );
                });
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
                    ModalRoute.withName("/Transaction"));
                }),
                Text('Profile',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}
