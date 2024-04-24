// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(" To be implemented"),
      actions: [
        SizedBox(
          height: 40,
          child: Column(
            children: [
              TextButton(onPressed: () {
                Navigator.pop(context, true);
              }, child: const Text("OK", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      ]
    );
  }
}