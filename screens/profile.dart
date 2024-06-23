//-- rencananya profile dipindah ke drawer
import 'package:flutter/material.dart';

import 'package:chocobi/screens/settings.dart';
import 'package:chocobi/screens/buttonnav.dart';

import 'package:chocobi/screens/welcome.dart';
import 'package:chocobi/screens/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

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
            color: const Color.fromARGB(255, 17, 80, 156),
            height: MediaQuery.of(context).size.height/4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 51,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('lib/assets/profile.jpg'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Shinchan",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white
                            ),
                          ),
                          IconButton(onPressed: () {
                            //--
                          },
                          icon: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 18,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "shinchan@gmail.com",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      const Text(
                        "08116075384",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            onTap: () {
              //--
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Export Data'),
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
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Welcome()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      drawer: const CustomDrawer(),
    );
  }
}
