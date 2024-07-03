import 'package:flutter/material.dart';

class dropDownScreen extends StatefulWidget {
  const dropDownScreen({super.key});

  @override
  State<dropDownScreen> createState() => _dropDownScreenState();
}

class _dropDownScreenState extends State<dropDownScreen> {
  List <String> pilihan = ["satu", "dua", "tiga"];
  String dropDownValue = "satu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop Down ${dropDownValue}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text("Choose one"),
              items: pilihan.map((pilihan) {
                return DropdownMenuItem( 
                  value: pilihan,
                  child: Text(pilihan)  
                );
              }).toList(), 
              onChanged: (newValue){
                setState(() {
                  dropDownValue = newValue!;
                });
              },
            ),
            SizedBox(height: 50,),
            DropdownMenu(
              label: Text("Choose one"),
              dropdownMenuEntries: pilihan.map((e) => 
                DropdownMenuEntry(
                  leadingIcon: const Icon(Icons.class_outlined),
                  value: dropDownValue, label: e)
              ).toList())
          ],
        ),
      ),
    );
  }
}