import 'package:flutter/material.dart';

// setState untuk jumlah karakter (cek banyak karakter)
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final sampleUser = ['kenneths', 'lionggo'];

  @override
  Widget build(BuildContext context) {
    var status = "";

    return AlertDialog(
      title: Text("Log in to Chocobi"),
      actions: [
        TextButton(onPressed: (){}, child: Text("Log in", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
        TextButton(onPressed: (){Navigator.pop(context, true);}, child: Text("Cancel", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
      ],
      content: SizedBox(
        height: 400,
        width: 350,
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Enter username",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            onChanged: (value) {
                setState(() {
                  status = value;
                });
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter password",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                status = value;
              });
            }
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: (){},
            child: Text('Forgot password?')
          ),
          SizedBox(
            height: 80,
          ),
          Text(status)],
        ),
      ),
    );
  }
}