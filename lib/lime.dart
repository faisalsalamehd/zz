import 'package:flutter/material.dart';

class Lime extends StatelessWidget {
  const Lime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.lightGreen, width: 2),
          ),
          child: Column(
            children: [
              Center(
                child: Image.network(
                  "https://thumbs.dreamstime.com/b/fresh-lime-over-white-background-32867420.jpg",
                  height: 190,
                  width: 190,
                ),
              ),
              Text(
                "1.22\$",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Oeganic Lime",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "4pcs Fresh and healthy limes",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 60,
                      width: 230,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              "   add to cart",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
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