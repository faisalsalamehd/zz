import 'package:get/get.dart';
import 'package:zz/routes/routes_string.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // بعد 3 ثواني، ينتقل إلى صفحة View1 (onboarding)
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RoutesStrings.view1);
    });
  }
}
