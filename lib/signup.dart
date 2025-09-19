import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController userNamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phcontroller = TextEditingController();
  final TextEditingController passWordcontroller = TextEditingController();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();

  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  final usernameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{2,}$');

  final passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  final phoneRegExp = RegExp(r'^[0-9]{10}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text("SignUp", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/jpg/LP!.jpg", fit: BoxFit.cover),
          ),

          Container(color: Colors.black.withOpacity(0.3)),

          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 16),
              child: Form(
                key: form1,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 440),

                    TextFormField(
                      controller: userNamecontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 6, 0),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: "Username",
                        iconColor: Color.fromARGB(255, 89, 6, 0),
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username is required';
                        }
                        if (!usernameRegExp.hasMatch(value.trim())) {
                          return 'Username must start with a letter & be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 6, 0),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: "Email",
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
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
                    SizedBox(height: 24),

                    TextFormField(
                      controller: phcontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 6, 0),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: "Phone Number",
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        if (!phoneRegExp.hasMatch(value.trim())) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    TextFormField(
                      controller: passWordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 6, 0),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: "Password",
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        if (!passwordRegExp.hasMatch(value.trim())) {
                          return 'Password must be 8+ chars, include upper, lower, number & special char';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passWordcontroller.text,
                          );
                        } catch (e) {
                          print(e);
                        }

                        if (form1.currentState!.validate() &&
                            emailcontroller.text.trim() ==
                                FirebaseAuth.instance.currentUser?.email) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Form submitted successfully ✅",
                                style: TextStyle(fontSize: 22),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  "Form didn't submit ❌",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              backgroundColor: Color.fromARGB(255, 89, 6, 0),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 89, 6, 0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
