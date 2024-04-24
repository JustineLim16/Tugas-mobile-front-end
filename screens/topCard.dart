import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35, left: 10, right: 10),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 17, 80, 156)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20,left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("B A L A N C E", style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
              Text("\$ 10,000", style: TextStyle(fontSize: 40, color: Colors.grey[100])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.grey[100]),
                      Column(
                        children: [
                          Text("Income", style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                          Text("\$ 20,000", style: TextStyle(fontSize: 10, color: Colors.grey[100]))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_downward, color: Colors.grey[100]),
                      Column(
                        children: [
                          Text("Expense", style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                          Text("\$ 10,000", style: TextStyle(fontSize: 10, color: Colors.grey[100]))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}