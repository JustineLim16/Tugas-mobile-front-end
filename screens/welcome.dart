import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chocobi/screens/profile.dart';
import 'package:chocobi/screens/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 96, 189),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset('lib/assets/welcome.png', scale: 2.4,),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Manage your finance like a pro", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',fontSize: 31.0, fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Text("Track and analyze all your incomes and expenses in one app", style: TextStyle(color: Colors.white, fontFamily: 'Open Sans',fontSize: 17.0, fontWeight: FontWeight.w700)),
                    SizedBox(height: 30),
                    Container(
                      width: 550,
                      child: ElevatedButton(
                        child: Text("Log in", style: TextStyle(color: Colors.black, fontFamily: 'Montserrat',fontSize: 20.0, fontWeight: FontWeight.w700),),
                        onPressed: (){showDialog(context: context, builder: (context){return const Login();},);},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(350, 65), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 550,
                      child: ElevatedButton(
                        child: Text("Sign up", style: TextStyle(color: Colors.black, fontFamily: 'Montserrat',fontSize: 20.0, fontWeight: FontWeight.w700),),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile())),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(350, 65), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}