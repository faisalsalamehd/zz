
import 'package:flutter/material.dart';

class BATMAN extends StatelessWidget {
  const BATMAN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new, color: Colors.amber, size: 25),
        title: Text(
          "BATMAN",
          style: TextStyle(
            fontSize: 24.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            backgroundColor: const Color.fromARGB(255, 255, 193, 7),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_4_sharp),
            iconSize: 45,
            color: Colors.amber,
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,

          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(32.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Gotham Knight",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
