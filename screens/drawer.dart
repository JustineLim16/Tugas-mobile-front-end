import 'package:flutter/material.dart';

import 'package:chocobi/screens/settings.dart';
import 'package:chocobi/screens/welcome.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List light = [Colors.white, Colors.black, Colors.grey[300]];
  List dark = [Colors.black, Colors.white, Colors.grey[800]];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        //-- rencananya profile pindah ke sini
        child: ListView(
          children: [
            Container(
              color: const Color.fromARGB(255, 17, 80, 156),
              height: MediaQuery.of(context).size.height/3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 63,
                        backgroundImage: AssetImage('lib/assets/profile.jpg'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('Shinchan')
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
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportSuccessPage()),
                );*/
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
      ),
    );
  }
}