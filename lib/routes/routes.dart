import 'package:flutter/material.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:zz/view/auth/log_in/log_in.dart';
import 'package:zz/view/home/home.dart';
import 'package:zz/view/splash/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.splash:(context)=>const Splash(),
  RoutesStrings.login:(context)=>const LogIn(),
  RoutesStrings.home:(context)=>const Home()
};
