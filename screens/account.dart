import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 80, 156),
        title: const Text(
          'Account Card',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: const Color.fromARGB(255, 17, 80, 156),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder:(context, index, realIndex) => 
                  const Card(
                    child: Text('oke kul kul'),
                  ),
                options: CarouselOptions()
              ),
            ),
          ),
          SizedBox(
            child: Text('oke kul')
          ),
          SizedBox(
            child: Text('oke kul'),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 48.0,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 17, 80, 156),
          child: const Text(
            'Add New Account',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            )
          ),
          onPressed: () {
        
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}