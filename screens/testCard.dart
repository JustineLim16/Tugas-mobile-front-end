import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key, this.text = 'Function to be implemented'});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(text, style: const TextStyle(fontSize: 18)),
              TextButton(onPressed: () {
                Navigator.pop(context, true);
              }, 
                child: const Text(
                  "OK", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)
                )
              ),
            ],
          ),
        ),
      ]
    );
  }
}