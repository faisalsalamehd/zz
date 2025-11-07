import 'package:get/get.dart';

class SplashController extends GetxController {

  String name = "Zain";
  int counter = 0;

  void increment() {
    counter++;
    update();
  }

  void decrement() {
    counter--;
    update();
  }


}