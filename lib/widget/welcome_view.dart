import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B6C64),
      body: Column(
        children: [
          const SizedBox(height: 250),
          Center(child: Image.asset("assets/png/fresh cart Logo.png")),
          const SizedBox(height: 70),
          Expanded(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome 👋",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "If you already have a grocery account, enter your email below.",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(RoutesStrings.login);
                            },
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B6C64),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Text(
                                "Continue with Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          InkWell(
                            onTap: () {
                              Get.snackbar(
                                "Apple Login",
                                "Feature coming soon!",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.apple, size: 30),
                                  SizedBox(width: 15),
                                  Text(
                                    "Sign in with Apple",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          InkWell(
                            onTap: () {
                              Get.snackbar(
                                "Google Login",
                                "Feature coming soon!",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.account_circle, size: 30),
                                  SizedBox(width: 15),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account? ",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                '/register',
                              ); // Navigate to register page
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3B6C64),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
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
          ),
        ],
      ),
    );
  }
}
