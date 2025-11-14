import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/screens/auth/login/splash_login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) => Scaffold(appBar: AppBar(title: Text(ctrl.name))),
    );
  }
}
