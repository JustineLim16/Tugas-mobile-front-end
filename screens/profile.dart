import 'package:chocobi/screens/account.dart';
import 'package:chocobi/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chocobi/screens/button_nav.dart';
import 'package:chocobi/screens/export.dart';
import 'package:chocobi/screens/welcome.dart';
import 'package:chocobi/data/account_data.dart';

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
                      backgroundImage: Provider.of<ProfileNotifier>(context).accountInfo["picStatus"] == "asset" 
                            ? AssetImage(Provider.of<ProfileNotifier>(context).accountInfo["profilePic"])
                            : NetworkImage(Provider.of<ProfileNotifier>(context).accountInfo["profilePic"]) as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((Provider.of<ProfileNotifier>(context).accountInfo["name"]), style: TextStyle(fontSize: 22, color: Colors.white)),    
                      Text((Provider.of<ProfileNotifier>(context).accountInfo["email"]), style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                      Text((Provider.of<ProfileNotifier>(context).accountInfo["phone"]), style: TextStyle(fontSize: 19, color: Colors.white, fontStyle: FontStyle.italic)),
                    ],
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExportSuccessPage("PDF")),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.table_chart),
                          title: Text('Excel'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExportSuccessPage("Excel")),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.description),
                          title: Text('Word'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExportSuccessPage("Word")),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.image),
                          title: Text('JPG'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExportSuccessPage("JPG")),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.text_snippet),
                          title: Text('RTF'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExportSuccessPage("RTF")),
                            );
                          },
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
