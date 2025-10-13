import 'package:flutter/material.dart';
import 'package:zz/core/theme/app_color.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:zz/utils/conestant/images_conest.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigateToNextScreen();
    super.initState();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, RoutesStrings.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Image.asset(ImagesConstants.logo, height: 200)),
    );
  }
}
