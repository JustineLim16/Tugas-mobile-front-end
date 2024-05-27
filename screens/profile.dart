import 'package:chocobi/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:chocobi/screens/home.dart';
import 'package:chocobi/screens/testCard.dart';
import 'package:chocobi/screens/transaction.dart';
import 'package:provider/provider.dart';
import 'package:chocobi/screens/button_nav.dart';
import 'package:chocobi/screens/welcome.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List light = [Colors.white, Colors.black];
  List dark = [Colors.black, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Color.fromARGB(255, 17, 80, 156),
            height: MediaQuery.of(context).size.height/4,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.upload),
            title: Text('Export Data'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 250,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.picture_as_pdf),
                          title: Text('PDF'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.table_chart),
                          title: Text('Excel'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.description),
                          title: Text('Word'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.image),
                          title: Text('JPG'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.text_snippet),
                          title: Text('RTF'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
