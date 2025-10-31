import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zz/firebase_options.dart';
import 'package:zz/routes/routes.dart';
import 'package:zz/routes/routes_strings.dart';
import 'messeages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'custom_illustrations.dart';

Future<void> requestAndroidNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

/// 🔹 Annotate background handler so it's not tree-shaken
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📥 Background message: ${message.messageId}");
}

void _printFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("🔥 Direct token check in main: $token");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🔹 Ask for Android 13+ notification permission
  await requestAndroidNotificationPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  _printFCMToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talabat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B35),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFF6B35),
          secondary: const Color(0xFFFF6B35),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      initialRoute: RoutesStrings.welcome,
    );
  }
}
