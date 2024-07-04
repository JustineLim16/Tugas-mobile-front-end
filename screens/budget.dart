import 'package:chocobi/screens/button_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156), 
        title: Text(
          "Financial Report", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  strokeWidth: 20,
                  color: Colors.red,
                  backgroundColor: Colors.grey,
                  value: 0.5,

                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar()
    );
  }
}