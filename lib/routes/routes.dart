import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: RoutesStrings.splash,
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
];