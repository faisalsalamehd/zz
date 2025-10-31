import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zz/routes/routes_strings.dart';

class forgetpass extends StatelessWidget {
  forgetpass({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _resetPassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent ✅"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, RoutesStrings.login);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error ❌: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesStrings.login);
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),

                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Reset Button
                    ElevatedButton(
                      onPressed: () => _resetPassword(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 97, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Send Reset Email",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
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
