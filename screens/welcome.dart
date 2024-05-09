import 'package:flutter/material.dart';

import 'package:chocobi/screens/login.dart';
import 'package:chocobi/screens/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 96, 189),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'lib/assets/welcome.png',
                scale: 2.4,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Manage your finance like a pro",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 31.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Track and analyze all your incomes and expenses in one app",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Open Sans',
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 550,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, builder: (context){
                            return const LoginPage();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(350, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      child: const Text("Log In", style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 550,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                            return const RegisterPage();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(350, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      child: const Text("Register", style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}