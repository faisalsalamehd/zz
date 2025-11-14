import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/data/models/login/login_screen_model.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = 'Zain';
  String email = 'zain@example.com';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreenModel loginModel = LoginScreenModel(
    username: '',
    password: '',
  );

}
