import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz/screens/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.lazyPut(() => SplashController());   stupid mistake
    return GetBuilder<SplashController>(
      builder: (ctrl) => Scaffold(
        appBar: AppBar(title: Text(ctrl.name)),
        // create ui for increment and decrement
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
                ctrl.decrement();
              }, child: Text("decrement")),
              Text(ctrl.counter.toString(), style: TextStyle(fontSize: 30)),
              ElevatedButton(onPressed: () {
                ctrl.increment();
              }, child: Text("increment")),
            ],
          ),
        ),
      ),
    );
  }
}
