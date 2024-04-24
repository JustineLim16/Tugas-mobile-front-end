import 'package:flutter/material.dart';
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/testCard.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 17, 80, 156),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 51,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('lib/assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Shinchan", style: TextStyle(fontSize: 22, color: Colors.white)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit_rounded, color: Colors.white, size: 18,))
                        ],
                      ),
                      Text("shinchan@gmail.com", style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                      Text("08116075384", style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                    ],
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account'),
            onTap: () {
              // Aksi untuk 'Account'
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Aksi untuk 'Settings'
            },
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text('Export Data'),
            onTap: () {
              // Aksi untuk 'Export Data'
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Aksi untuk 'Logout'
            },
          ),
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
                IconButton(icon: Icon(Icons.home, size: 30), onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    ModalRoute.withName("/Profile"));
                }),
                Text('Home',style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), 
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
                                  TextButton(onPressed: (){}, child: Text("CANCEL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
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
                        TextButton(onPressed: (){}, child: Text("CANCEL",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
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
                IconButton(icon: Icon(Icons.person, size: 30, color: Color.fromARGB(255, 17, 80, 156)), onPressed: () {}),
                Text('Profile',style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 17, 80, 156), fontWeight: FontWeight.bold)), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}