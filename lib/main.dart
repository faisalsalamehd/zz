import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/routes/routes.dart';
import 'package:zz/routes/routes_string.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';
import 'package:zz/widget/forget_password.dart';
import 'package:zz/widget/new_password.dart';
import 'package:zz/screens/welcome/welcome_view.dart';
import 'package:zz/widget/register_View.dart';
import 'package:zz/widget/onbordaring1.dart';
import 'package:zz/widget/onbordaring2.dart';
import 'package:zz/widget/onbordaring3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Cart',
      getPages: getPages,
    );
  }
}
