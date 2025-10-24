import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zz/core/theme/app_color.dart';
import 'package:zz/utils/helpers/validations.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  bool _obscurePassword = true;
  String ss = "";
  void search( String search)async{
    http.Response searchResponse = await http .get (
      Uri .parse ("'https://dummyjson.com/products'/search?q=$search")
    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Text(
                      'Fresh Cart',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Please log in to your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            ss =value;
                            search(ss);
                          },
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value) =>
                              ValidationsMethod.validateName(value),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                !_obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) =>
                              ValidationsMethod.validatePassword(value),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              http.Response response = await http.post(
                                Uri.parse("https://dummyjson.com/user/login"),
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode({
                                  "username": "emilys",
                                  "password": "emilyspass",
                                  "expiresInMins": 10,
                                }),
                              );
                              Map<String, dynamic> responseData = json.decode(
                                response.body,
                              );
                              // log(responseData['accessToken']);
                              http.Response res2 = await http.get(
                                Uri.parse("https://dummyjson.com/auth/me"),
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization":
                                      "Bearer ${responseData['accessToken']}",
                                },
                              );
                              //log(res2.body);
                              // http.Response res3 = await http.post(
                              //   Uri.parse("https://dummyjson.com/auth/refresh"),
                              //   //  headers:  { 'Content-Type': 'application/json'},
                              //   body: {
                              //     "refreshToken :${responseData['refreshToken']}",
                              //   },
                              // );
                              //log(res3.body);
                              http.Response res4 = await http.get(
                                Uri.parse ("https://dummyjson.com/products",
                                )
                              );
                              //log(res4.body);
http.Response res5 = await http.get(
                                Uri.parse ("https://dummyjson.com/products/1",
                                )
                              );
                             // log(res5.body);
                              http.Response res6 = await http . get(
                                Uri.parse ("https://dummyjson.com/products/search?q=phone")
                              );
                             // log(res6.body);
                              http.Response res7 = await http.get(
                                Uri.parse ("https://dummyjson.com/products?limit=10&skip=10&select=title,price")
                              );
                              log(res7.body);




                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
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
      ),
    );
  }
}
