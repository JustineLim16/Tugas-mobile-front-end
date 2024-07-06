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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: const Color.fromARGB(255, 17, 80, 156),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder:(context, index, realIndex) => 
                    SizedBox(
                      width: 256.0,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.password),
                                  SizedBox(width: 16.0),
                                  Text('CIMB NIAGA')
                                ], 
                              ),
                              SizedBox(height: 16.0),
                              Icon(Icons.sim_card_outlined),
                              SizedBox(height: 8.0),
                              Text('4284 1688 8888 8888')
                            ],
                          ),
                        )
                      ),
                    ),
                  options: CarouselOptions()
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text('Account Information')
                
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Text('oke kul'),
            ),
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