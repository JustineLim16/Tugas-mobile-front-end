import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 17, 80, 156),
              width: double.infinity,
              height: MediaQuery.of(context).size.height/3,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 63,
                        backgroundImage: AssetImage('lib/assets/profile.jpg'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('Shinchan')
                  ],
                ),
              )
            ),
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder:(context, index, realIndex) => 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Text('help')
                      ],
                    ),
                  ),
                ),
              options: CarouselOptions()
            )
          ],
        ),
      ),
    );
  }
}
