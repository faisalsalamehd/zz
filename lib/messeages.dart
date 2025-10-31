import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zz/wel.dart';

Future<void> backgroundmsghandler(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

class InitialMSG extends StatefulWidget {
  const InitialMSG({super.key});

  @override
  State<InitialMSG> createState() => _InitialMSGState();
}

class _InitialMSGState extends State<InitialMSG> {
  @override
  void initState() {
    super.initState();
    _initMessaging();
  }

  Future<void> _initMessaging() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission();

    print("🔔 Permission granted: ${settings.authorizationStatus}");

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print("📩 Foreground message received");
      print("Title: ${msg.notification?.title}");
      print("Body: ${msg.notification?.body}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      print("📲 App opened via notification");
      print("Title: ${msg.notification?.title}");
      print("Body: ${msg.notification?.body}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Welcome()),
      );
    });

    String? token = await FirebaseMessaging.instance.getToken();
    print("🔥 Initial FCM Token: $token");

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("♻️ Refreshed FCM Token: $newToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Firebase Messaging Initialized")),
    );
  }
}
