import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RoutesStrings.welcome);
    });
  }
}
