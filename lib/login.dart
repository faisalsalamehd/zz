import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String ss = "";
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful 🎉"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, RoutesStrings.home);
    } on FirebaseAuthException catch (e) {
      String message = "Login failed ❌";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void search(String search) async {
    http.Response searchFun = await http.get(
      Uri.parse("https://dummyjson.com/products/search?q=$search"),
    );
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
            Navigator.pushReplacementNamed(context, RoutesStrings.accountint);
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Continue with email",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  onChanged: (value) {
                    ss = value;
                    search(ss);
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    fillColor: Colors.white.withOpacity(0.8),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    fillColor: Colors.white.withOpacity(0.8),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Login Button
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          http.Response response = await http.post(
                            Uri.parse("https://dummyjson.com/user/login"),
                            headers: {"Content-type": "application/json"},
                            body: jsonEncode({
                              "username": "emilys",
                              "password": "emilyspass",
                            }),
                          );
                          Map<String, dynamic> responseData = json.decode(
                            response.body,
                          );
                          // log(responseData["accessToken"]);

                          http.Response res = await http.get(
                            Uri.parse("https://dummyjson.com/auth/me"),
                            headers: {
                              "Content-type": "application/json",
                              "Authorization":
                                  "Bearer ${responseData["accessToken"]}",
                            },
                          );
                          // log(res.body);

                          http.Response resauth = await http.post(
                            Uri.parse("https://dummyjson.com/auth/refresh"),
                            //  headers: {'Content-Type': 'application/json'},
                            body: {
                              "refreshToken": "${responseData["refreshToken"]}",
                            },
                          );
                          // log(resauth.body);

                          http.Response prod = await http.get(
                            Uri.parse("https://dummyjson.com/products"),
                          );
                          //log(prod.body);

                          http.Response prod1 = await http.get(
                            Uri.parse("https://dummyjson.com/products/1"),
                          );
                          //log(prod1.body);

                          http.Response search = await http.get(
                            Uri.parse(
                              "https://dummyjson.com/products/search?q=phone",
                            ),
                          );
                          // log(search.body);

                          http.Response searchlimit = await http.get(
                            Uri.parse(
                              "https://dummyjson.com/products?limit=10&skip=10&select=title,price",
                            ),
                          );
                          // log(searchlimit.body);

                          http.Response sort = await http.get(
                            Uri.parse(
                              "https://dummyjson.com/products?sortBy=title&order=asc",
                            ),
                          );

                          log(sort.body);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            97,
                            0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RoutesStrings.forgetPassword,
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 97, 0),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RoutesStrings.signup),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 97, 0),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 97, 0),
                  ),
                  child: const Text(
                    "button",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
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
