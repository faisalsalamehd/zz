import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';
<<<<<<< HEAD
import 'package:zz/screens/auth/login/login_binding.dart';
import 'package:zz/screens/auth/login/login_view.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';
import 'package:zz/widget/login_view.dart';
=======
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';
import 'package:zz/widget/email_login_view.dart';
import 'package:zz/widget/forget_password.dart';
import 'package:zz/widget/new_password.dart';
import 'package:zz/widget/welcome_view.dart';
>>>>>>> e1f1f66811987a726d665933828752728eaaf16f
import 'package:zz/widget/register_View.dart';
import 'package:zz/widget/onbordaring1.dart';
import 'package:zz/widget/onbordaring2.dart';
import 'package:zz/widget/onbordaring3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Cart',
      initialRoute: RoutesStrings.splash,
      getPages: [
        GetPage(
          name: RoutesStrings.splash,
          page: () => const SplashView(),
          binding: SplashBinding(),
        ),
        GetPage(name: RoutesStrings.view1, page: () => const View1()),
        GetPage(name: RoutesStrings.view2, page: () => const View2()),
        GetPage(name: RoutesStrings.view3, page: () => const View3()),
        GetPage(name: RoutesStrings.welcome, page: () => const WelcomeView()),
        GetPage(name: RoutesStrings.register, page: () => const RegisterView()),
        GetPage(name: RoutesStrings.login, page: () => const EmailLoginView()),
        GetPage(
          name: RoutesStrings.forgotPassword,
          page: () => const ForgetPassword(),
        ),
        GetPage(
          name: RoutesStrings.newPassword,
          page: () => const NewPassword(),
        ),
      ],
    );
  }
}
