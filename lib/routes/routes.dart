import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zz/routes/routes_string.dart';
import 'package:zz/screens/splash/splash_binding.dart';
import 'package:zz/screens/splash/splash_view.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: RoutesString.splash,
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
];