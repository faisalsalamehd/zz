import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zz/routes/routes_strings.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _offersChecked = true;

  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  final nameRegExp = RegExp(r'^[a-zA-Z]{2,}$'); // at least 2 letters

  final Color mainColor = const Color.fromARGB(255, 255, 97, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          "Welcome to talabat",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Create your account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24),

              // First Name
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: "First name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'First name is required';
                  }
                  if (!nameRegExp.hasMatch(value.trim())) {
                    return 'Enter a valid first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last Name
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: "Last name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Last name is required';
                  }
                  if (!nameRegExp.hasMatch(value.trim())) {
                    return 'Enter a valid last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!emailRegExp.hasMatch(value.trim())) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Text(
                      _obscurePassword ? "Show" : "Hide",
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  if (value.trim().length < 6 || value.trim().length > 16) {
                    return 'Password should be between 6 and 16 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              const Text(
                "Passwords should be between 6 and 16 characters",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // Offers Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _offersChecked,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        _offersChecked = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "Yes, I want to receive offers and discounts",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Create Account Button
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                    String fullName =
                        "${firstNameController.text.trim()} ${lastNameController.text.trim()}";
                    await userCredential.user!.updateDisplayName(fullName);
                    await userCredential.user!.reload();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sign Up successful ✅ Please Sign In"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamed(context, RoutesStrings.welcome);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign Up failed ❌: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Create your account",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "By creating an account you agree to the ",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ),
                  const Text(
                    " and to the",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Terms of Use",
                      style: TextStyle(fontSize: 14, color: mainColor),
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
}
