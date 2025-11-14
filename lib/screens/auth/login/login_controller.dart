import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/data/api/api_cliant.dart';
import 'package:zz/data/api/api_string.dart';
import 'package:zz/data/models/login/login_screen_model.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = 'Zain';
  String email = 'zain@example.com';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreenModel loginModel = LoginScreenModel(username: '', password: '');

  void login() async {
    loginModel.username = usernameController.text;
    loginModel.password = passwordController.text;
    
    http.Response response = await ApiClient.post(
      url: ApiString.baseUrl + ApiString.login,
      body: loginModel.toJson(),
      withAuth: false
    );
    log(response.body);
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Login successful',
          snackPosition: SnackPosition.BOTTOM);
      // Navigate to another screen or perform other actions
    } else {
      Get.snackbar('Error', 'Login failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
