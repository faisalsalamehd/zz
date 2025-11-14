import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class OtpPage extends StatefulWidget {
  final String contactInfo; // phone or email shown on screen

  const OtpPage({super.key, required this.contactInfo});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  final String correctCode = "6942"; // ✅ your unique code

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining == 0) {
        setState(() => enableResend = true);
        t.cancel();
      } else {
        setState(() => secondsRemaining--);
      }
    });
  }

  void verifyCode() {
    String enteredCode = controllers
        .map((controller) => controller.text)
        .join();

    if (enteredCode == correctCode) {
      Get.snackbar(
        "Success",
        "OTP Verified Successfully!",
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.green.shade800,
      );
      Future.delayed(const Duration(milliseconds: 800), () {
        Get.offNamed('/newPassword'); // ✅ go to next screen
      });
    } else {
      Get.snackbar(
        "Invalid Code",
        "Please enter the correct verification code.",
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red.shade800,
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offNamed('/forgetPassword'),
        ),
        title: const Text(
          "OTP Page",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Verification code",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "A verification code has been sent to",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              widget.contactInfo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),

            // OTP input boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Resend code section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!enableResend)
                  Text(
                    "Resend code in ${secondsRemaining}s",
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        secondsRemaining = 60;
                        enableResend = false;
                        for (var c in controllers) c.clear();
                      });
                      startTimer();
                      Get.snackbar("Code Sent", "A new OTP has been sent!");
                    },
                    child: const Text(
                      "Resend code",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 40),

            // Verify button
            ElevatedButton(
              onPressed: verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Send",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Back to "),
                GestureDetector(
                  onTap: () => Get.offNamed('/login'),
                  child: const Text(
                    "signin",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
