import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Insert Transaction"),
      actions: [
        TextButton(onPressed: (){}, child: Text("ADD", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
        TextButton(onPressed: (){Navigator.pop(context, true);}, child: Text("CANCEL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
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
    );
  }
}