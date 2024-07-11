import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  final Map<String, dynamic> _accountInfo = {
    "profilePic": "lib/assets/profile.jpg",
    "name": "",
    "email": "",
    "phone": "-",
    "picStatus": "asset"
  };

  Map<String, dynamic> get accountInfo => _accountInfo;

  void updateProfilePic(String image, String stats) {
    _accountInfo["profilePic"] = image;
    _accountInfo["picStatus"] = stats;
    notifyListeners();
  }

  void updateProfileData(String info, String data) {
    _accountInfo[info] = data;
    notifyListeners();
  }
}
