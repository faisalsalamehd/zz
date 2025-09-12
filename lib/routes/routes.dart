import 'package:flutter/material.dart';
import 'package:zz/login.dart';
import 'package:zz/signup.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:zz/wel.dart';

Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.splash:(context)=>asd(),
  RoutesStrings.login:(context)=>Login(),
    RoutesStrings.signup:(context)=>Signup(),

};
