import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color newColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 50,
                      color: Colors.pink,
                      child: const Center(
                        child: Text(
                          "4.7",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          newColor = newColor == Colors.black
                              ? Colors.red
                              : Colors.black;
                        });
                      },
                      icon: Icon(
                        newColor == Colors.black
                            ? Icons.favorite_border_outlined
                            : Icons.favorite,
                        size: 40,
                        color: newColor,
                      ),
                    ),
                  ],
                ),
              ),
              Image.network(
                "https://freepngimg.com/save/24846-ferrari-transparent-image/624x300",
                height: 415,
                width: 415,
              ),
              const Text("Car", style: TextStyle(fontSize: 30)),
              const Text("Red Sport Car"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "230,000\$",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 30,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.blue),
                          boxShadow: const [],
                        ),
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
