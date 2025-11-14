import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
  
    return GetBuilder<SplashController>(builder: (ctrl) => Scaffold(
       backgroundColor: const Color(0xFF3B6C64),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
              child: Image.asset("assets/png/fresh cart Logo.png"),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Freshness Delivered to Your Doorstep",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),);
}
}