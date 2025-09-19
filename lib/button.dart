import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          width: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 7,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Button",
              style: TextStyle(fontSize: 26, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
