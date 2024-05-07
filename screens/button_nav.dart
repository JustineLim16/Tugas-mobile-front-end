import 'package:chocobi/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:chocobi/screens/testCard.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      color: Colors.white,
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
              MaterialPageRoute(builder: (context) => Transaction()),
              ModalRoute.withName("/Home"),
            );
          }),
          _buildBottomAppBarItem(Icons.account_balance_wallet, 'Budget', () {
            showDialog(context: context, builder: (context) => const TestCard());
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
