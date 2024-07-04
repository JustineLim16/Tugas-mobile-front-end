import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SettingsModel with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  bool _pushNotifications = false;
  bool get pushNotifications => _pushNotifications;
  set pushNotifications(bool value) {
    _pushNotifications = value;
    notifyListeners();
  }

  bool _soundNotifications = false;
  bool get soundNotifications => _soundNotifications;
  set soundNotifications(bool value) {
    _soundNotifications = value;
    notifyListeners();
  }

  String _selectedLanguage = 'English';
  String get selectedLanguage => _selectedLanguage;
  set selectedLanguage(String value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  // Tambahkan state dan logika bisnis lainnya di sini jika diperlukan
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<SettingsModel>(context).isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
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
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.arrow_back, color: Colors.white)
          ),
        ),
        body: Consumer<SettingsModel>(
          builder: (context, settings, child) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Dark Mode'),
                  trailing: Switch(
                    value: settings.isDarkMode,
                    onChanged: (value) {
                      settings.isDarkMode = value;
                    },
                    activeColor: Color.fromARGB(255, 17, 80, 156),
                  ),
                ),
                ListTile(
                  title: Text('Push Notifications'),
                  trailing: Switch(
                    value: settings.pushNotifications,
                    onChanged: (value) {
                      settings.pushNotifications = value;
                    },
                    activeColor: Color.fromARGB(255, 17, 80, 156)
                  ),
                ),
                ListTile(
                  title: Text('Sound Notifications'),
                  trailing: Switch(
                    value: settings.soundNotifications,
                    onChanged: (value) {
                      settings.soundNotifications = value;
                    },
                    activeColor: Color.fromARGB(255, 17, 80, 156)
                  ),
                ),
                ListTile(
                  title: Text('Language'),
                  trailing: DropdownButton<String>(
                    value: settings.selectedLanguage,
                    onChanged: (newValue) {
                      settings.selectedLanguage = newValue!;
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
            );
          },
        ),
      ),
    );
  }
}