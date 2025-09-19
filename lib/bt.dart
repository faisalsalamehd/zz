import 'package:flutter/material.dart';


class BT extends StatelessWidget {
  const BT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 900,
          width: 650,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.pink, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://thumbs.dreamstime.com/b/concept-design-super-sports-vehicle-car-auto-shop-logo-original-motor-silhouette-black-background-vector-illustration-70242426.jpg",

                height: 390,
                width: 390,
              ),
              Text(
                "Welcome to Flutter",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(offset: Offset(2, 2), color: Colors.pink)],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  height: 40,
                  width: 210,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.pink),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          "   Continue with Email",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 40,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.pink),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.g_mobiledata_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 40,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.pink),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.apple, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Continue with Apple",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
