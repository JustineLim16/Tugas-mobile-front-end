import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:chocobi/screens/topCard.dart';

class Home extends StatefulWidget {
  const Home ({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Tracker", style:TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 17, 80, 156),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
        body: const Column(
          children: [
            TopCard()
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.home, size: 30, color: Color.fromARGB(255, 17, 80, 156)), onPressed: () {}),
                Text('Home',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.swap_horiz, size: 30), onPressed: () {
                  showDialog(context: context, builder: (context){return const TestCard();});
                } ),
                Text('Transaction',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
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
                              ),
                            );
                          });
                        }, child: Text("ADD",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        TextButton(onPressed: (){Navigator.pop(context, true);}, child: Text("CANCEL",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
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
                    ModalRoute.withName("/Home"));
                }),
                Text('Profile',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      )
    );
  }
}