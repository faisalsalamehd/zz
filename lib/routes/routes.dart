import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';
import 'package:zz/screens/auth/login/login_binding.dart';
import 'package:zz/screens/auth/login/login_view.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';
import 'package:zz/screens/welcome/welcome_view.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: RoutesStrings.splash,
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: RoutesStrings.login,
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: RoutesStrings.welcome,
    page: () => const WelcomeView(),
  ),
];