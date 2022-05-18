import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  Widget imageCircleAvatar(Color colored, String assetName, String title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colored,
                blurRadius: 6,
                spreadRadius: 1,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          child: CircleAvatar(
            backgroundColor: colored,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(assetName),
            ),
            radius: 23,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 221, 221),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/menu.png', width: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What can you today?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 5,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    fillColor: Colors.white,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageCircleAvatar(
                  Colors.purple,
                  'assets/images/gym1.png',
                  'CrossFit',
                ),
                imageCircleAvatar(
                  Colors.deepOrange,
                  'assets/images/gym3.png',
                  'Gymnastics',
                ),
                imageCircleAvatar(
                  Colors.blue,
                  'assets/images/gym2.png',
                  'Fitness',
                ),
                imageCircleAvatar(
                  Colors.brown,
                  'assets/images/gym4.png',
                  'Aerobics',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
