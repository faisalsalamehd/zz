import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zz/firebase_options.dart';
import 'package:zz/insta.dart';
import 'package:zz/signup.dart';
import 'package:zz/routes/routes.dart';
import 'package:zz/wel.dart';

void main() {
  
  runApp(MyApp());
WidgetsFlutterBinding.ensureInitialized();
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: routes);
  }
}

class Lime extends StatelessWidget {
  const Lime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.lightGreen, width: 2),
          ),
          child: Column(
            children: [
              Center(
                child: Image.network(
                  "https://thumbs.dreamstime.com/b/fresh-lime-over-white-background-32867420.jpg",
                  height: 190,
                  width: 190,
                ),
              ),
              Text(
                "1.22\$",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Oeganic Lime",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "4pcs Fresh and healthy limes",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 60,
                      width: 230,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              "   add to cart",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BT extends StatelessWidget {
  const BT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 900,
          width: 650,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.pink, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://thumbs.dreamstime.com/b/concept-design-super-sports-vehicle-car-auto-shop-logo-original-motor-silhouette-black-background-vector-illustration-70242426.jpg",

                height: 390,
                width: 390,
              ),
              Text(
                "Welcome to Flutter",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(offset: Offset(2, 2), color: Colors.pink)],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  height: 40,
                  width: 210,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.pink),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          "   Continue with Email",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 40,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.pink),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.g_mobiledata_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 40,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.pink),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.apple, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Continue with Apple",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color newColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 50,
                      color: Colors.pink,
                      child: const Center(
                        child: Text(
                          "4.7",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          newColor = newColor == Colors.black
                              ? Colors.red
                              : Colors.black;
                        });
                      },
                      icon: Icon(
                        newColor == Colors.black
                            ? Icons.favorite_border_outlined
                            : Icons.favorite,
                        size: 40,
                        color: newColor,
                      ),
                    ),
                  ],
                ),
              ),
              Image.network(
                "https://freepngimg.com/save/24846-ferrari-transparent-image/624x300",
                height: 415,
                width: 415,
              ),
              const Text("Car", style: TextStyle(fontSize: 30)),
              const Text("Red Sport Car"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "230,000\$",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 30,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.blue),
                          boxShadow: const [],
                        ),
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}

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

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          width: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 7,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Button",
              style: TextStyle(fontSize: 26, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Color(0xff453548), size: 25),
        title: Text(
          "flutter",
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Center(
        child: Container(
          height: 60.0,
          width: MediaQuery.sizeOf(context).width,

          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Center(child: Text("flutter")),
        ),
      ),
    );
  }
}
