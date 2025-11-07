import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var agreeTerms = false.obs;
  final formKey = GlobalKey<FormState>();

  void toggleAgree(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const SingleChildScrollView(
          child: Text(
            "By creating an account, you agree to the following:\n\n"
            "1. You will provide accurate and truthful information.\n"
            "2. You are responsible for keeping your password secure.\n"
            "3. We may contact you for updates and verification.\n"
            "4. Your data will be handled in accordance with our privacy policy.\n\n"
            "If you do not agree, you cannot continue registration.",
            style: TextStyle(fontSize: 15),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              agreeTerms.value = false;
            },
            child: const Text("Decline"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              agreeTerms.value = true;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B6C64),
            ),
            child: const Text("I Agree"),
          ),
        ],
      ),
    );
  }

  void register() {
    if (!agreeTerms.value) {
      Get.snackbar(
        "Error",
        "You must agree to the Terms & Conditions.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "Success",
        "Registered Successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF3B6C64),
        colorText: Colors.white,
      );
    }
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/login'),
        ),
        title: const Text(
          'Signup',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Name field
                const Text("Your Name"),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your name" : null,
                ),

                const SizedBox(height: 15),

                // Email field
                const Text("Email Address"),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your email" : null,
                ),

                const SizedBox(height: 15),

                // Phone field
                const Text("Phone Number"),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your phone number" : null,
                ),

                const SizedBox(height: 15),

                // Password field
                const Text("Password"),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your password" : null,
                ),

                const SizedBox(height: 15),

                // Checkbox for terms
                Obx(() => Row(
                      children: [
                        Checkbox(
                          value: controller.agreeTerms.value,
                          onChanged: (_) => controller.toggleAgree(context),
                        ),
                        const Expanded(
                          child: Text(
                            "I agree with Terms & Conditions",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )),

                const SizedBox(height: 25),

                // Sign Up button
                GestureDetector(
                  onTap: controller.register,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B6C64),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: GestureDetector(
                    onTap: () => Get.offNamed('/login'),
                    child: const Text(
                      "Have an Account? Sign in",
                      style: TextStyle(
                        color: Color(0xFF3B6C64),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
