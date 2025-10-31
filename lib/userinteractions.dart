import 'package:flutter/material.dart';
import 'package:zz/routes/routes_strings.dart';

class accountint extends StatelessWidget {
  const accountint({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesStrings.welcome);
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: 90,
          child: Image.asset("assets/png/Group 92.png"),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/png/talabat1.png",
              fit: BoxFit.fill,
              width: 600,
            ),
            const SizedBox(height: 20),
            const Text(
              "Log in or create an account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "Receive rewards and save your details for a faster checkout \nexperience.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Google
            _LoginButton(
              text: "Continue with Google",
              icon: Image.asset("assets/png/google.png", height: 20),
              onTap: () {},
            ),
            const SizedBox(height: 15),

            // Facebook
            _LoginButton(
              text: "Continue with Facebook",
              icon: const Icon(
                Icons.facebook,
                color: Color.fromARGB(255, 0, 2, 120),
                size: 21,
              ),
              onTap: () {},
            ),
            const SizedBox(height: 15),

            // Apple
            _LoginButton(
              text: "Continue with Apple",
              icon: const Icon(Icons.apple, color: Colors.black, size: 24),
              onTap: () {},
            ),
            const SizedBox(height: 15),

            // Email
            _LoginButton(
              text: "Continue with Email",
              icon: const Icon(
                Icons.email,
                color: Color.fromARGB(255, 255, 97, 0),
                size: 24,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesStrings.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onTap;

  const _LoginButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
