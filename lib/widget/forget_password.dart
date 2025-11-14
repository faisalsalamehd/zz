import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/utils/contact_options.dart';
import 'package:zz/widget/otp_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String selectedOption = 'phone'; // default selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/login'),
        ),
        title: const Text(
          'Forget Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 180,
              backgroundImage: AssetImage('assets/png/forgot_password.png'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0),
            child: Text(
              "Select which contact details should we use to reset your password.",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                ContactChoice(
                  title: 'Vai massage',
                  subtitle: '+880 1741 669061',
                  icon: Icons.phone,
                  isSelected: selectedOption == 'phone',
                  onTap: () {
                    setState(() {
                      selectedOption = 'phone';
                    });
                  },
                ),
                const SizedBox(height: 12),
                ContactChoice(
                  title: 'Via Email',
                  subtitle: 'example@email.com',
                  icon: Icons.email,
                  isSelected: selectedOption == 'email',
                  onTap: () {
                    setState(() {
                      selectedOption = 'email';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => OtpPage(contactInfo: '+880 17•••••61'));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Send',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("back to "),
              GestureDetector(
                onTap: () {
                  Get.offNamed('/login');
                },
                child: Text(
                  "login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
