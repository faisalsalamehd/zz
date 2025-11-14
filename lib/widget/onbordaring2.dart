import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/widget/onbordaring3.dart';
<<<<<<< HEAD
import 'package:zz/widget/login_view.dart';
=======
import 'package:zz/widget/welcome_view.dart';
>>>>>>> e1f1f66811987a726d665933828752728eaaf16f

class View2 extends StatelessWidget {
  const View2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 45),

              Column(
                children: [
                  Image.asset("assets/png/view2.png"),
                  const SizedBox(height: 20),
                  const Text(
                    "Fresh Delivered, Hassle Free",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Find the favorites you want by your location or neighborhood.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
<<<<<<< HEAD
                      Get.offAll(() => const LoginViewPage());
=======
                      Get.offAll(() => const WelcomeView());
>>>>>>> e1f1f66811987a726d665933828752728eaaf16f
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      _buildDot(false),
                      const SizedBox(width: 6),
                      _buildDot(true),
                      const SizedBox(width: 6),
                      _buildDot(false),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => const View3());
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
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

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
