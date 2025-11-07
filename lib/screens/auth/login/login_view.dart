import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/data/api/api_cliant.dart';
import 'package:zz/data/api/api_string.dart';
import 'package:zz/screens/auth/login/login_controller.dart';
import 'package:http/http.dart' as http;
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) => Scaffold(
        appBar: AppBar(title: Text(ctrl.email)),
        body:  Center(child: GestureDetector(
          onTap: ()async{
            http.Response response = await ApiClient.post(
              url: ApiString.baseUrl + ApiString.login,
              body: {
                "username": "kminchelle",
                "password": "0lelplR",
              },
              withAuth: false
            );
          },
          child: Text("Login View"))),
      ),
    );
  }
}
