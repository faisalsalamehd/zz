import 'package:flutter/material.dart';
import 'package:zz/login.dart';
import 'package:zz/messeages.dart';
import 'package:zz/signup.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:zz/wel.dart';
import 'package:zz/concert.dart';

Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.wel: (context) => welcome(),
  RoutesStrings.login: (context) => Login(),
  RoutesStrings.signup: (context) => Signup(),
  RoutesStrings.splash: (context) => InitialMSG(),
  RoutesStrings.concert: (context) => Concert()
};
