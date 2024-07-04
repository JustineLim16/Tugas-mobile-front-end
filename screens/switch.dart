import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool light = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text("Switch"),
      ),
      body: Center(
        child: SwitchListTile(
          value: light, 
          onChanged: (value){
            setState(() {
              light = value;
            });
          },
          title: Text("${light ? "Light" : "Dark"}  Mode", style: TextStyle(
            color: !light ? Colors.white : Colors.black,
          )),
          subtitle: Text("Theme", style: TextStyle(
            color: !light ? Colors.white : Colors.black,
          )),
        // ListTile(
        //   title: Text("${light ? "Light" : "Dark"} Mode", style: TextStyle(
        //     color: !light ? Colors.white : Colors.black
        //   )),
        //   subtitle: Text("Theme", style: TextStyle(
        //     color: !light ? Colors.white : Colors.black
        //   )),
        //   leading: Switch(value: light, onChanged: (value){
        //     setState(() {
        //       light = value;
        //     });
        //   }),
        // ),
      ),
    )
    );
  }
}