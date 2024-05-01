import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _pushNotifications = false;
  bool _soundNotifications = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 80, 156),
          title: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Push Notifications'),
              trailing: Switch(
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Sound Notifications'),
              trailing: Switch(
                value: _soundNotifications,
                onChanged: (value) {
                  setState(() {
                    _soundNotifications = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Language'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['English', 'Indonesian', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
