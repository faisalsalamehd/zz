import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zz/concert.dart';
import 'package:zz/insta.dart';
import 'package:zz/main.dart';

class InitialMSG extends StatefulWidget {
  const InitialMSG({super.key});

  @override
  State<InitialMSG> createState() => _InitialMSGState();
}

class _InitialMSGState extends State<InitialMSG> {
  @override
  void initState() {
    messages();
    super.initState();
  }

  Future<void> messages() async {
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onBackgroundMessage(backgroundmsghandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print(msg.notification!.title);
      print(msg.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      print(msg.notification!.title);
      print(msg.notification!.body);
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Concert()),
      );
    });
    String? token = await FirebaseMessaging.instance.getToken();
    print("Initial token: $token");
  }

  Future<void> backgroundmsghandler(RemoteMessage msg) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
