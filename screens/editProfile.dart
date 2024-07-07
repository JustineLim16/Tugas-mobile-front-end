import 'dart:io';
import 'package:chocobi/data/account_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _phoneEditingController;
  bool emailValidity = false;
  bool phoneValidity = false;

  

  _getFromGallery() async {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500
      );
      if (pickedFile != null) {
        final image = pickedFile.path;
        final stats = "file";
        context.read<ProfileNotifier>().updateProfilePic(image, stats);
      }
    }

  void initState() {
    super.initState();
    _nameEditingController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _emailEditingController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _phoneEditingController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = Provider.of<ProfileNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white)),
        title: Text("Edit Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: 
                        profileNotifier.accountInfo["picStatus"] == "asset" 
                        ? AssetImage(profileNotifier.accountInfo["profilePic"])
                        : FileImage(File(profileNotifier.accountInfo["profilePic"])) as ImageProvider,
                    ),
                    TextButton(onPressed: (){_getFromGallery();}, child: Text("Edit picture", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: profileNotifier.accountInfo["name"],
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _nameEditingController,
                maxLength: 10,
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  context.read<ProfileNotifier>().updateProfileData("name", value);
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: profileNotifier.accountInfo["email"],
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _emailEditingController,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text != null && text.isNotEmpty) {
                    if (text.length < 4) {
                      return 'Too short';
                    }
                    if (!text.contains('@') || !text.contains('.') || text.contains(' ')) {
                      return 'Email is not valid';
                    }
                  }
                  if (text == null || text.isEmpty) {
                    return null;
                  }
                  emailValidity = true;
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (value.isEmpty || emailValidity == false) {
                    return;
                  }
                  context.read<ProfileNotifier>().updateProfileData("email", value);
                },
                ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: profileNotifier.accountInfo["phone"],
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _phoneEditingController,
                maxLength: 11,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text != null && text.isNotEmpty) {
                    if (text.length < 8) {
                      return 'Too short';
                    }
                  }
                  if (text == null || text.isEmpty) {
                    return null;
                  }
                  phoneValidity = true;
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (value.isEmpty || phoneValidity == false) {
                    return;
                  }
                  context.read<ProfileNotifier>().updateProfileData("phone", value);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
