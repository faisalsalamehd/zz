import 'package:flutter/material.dart';
import 'package:zz/widgets/eventitem.dart';
import 'package:zz/widgets/placeitem.dart';
import 'package:zz/widgets/performeritem.dart';


class Concert extends StatelessWidget {
  const Concert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  FilterChip(label: const Text("€40-90"), onSelected: (_) {}),
                  const SizedBox(width: 6),
                  FilterChip(label: const Text("When"), onSelected: (_) {}),
                  const SizedBox(width: 6),
                  FilterChip(label: const Text("Category"), onSelected: (_) {}),
                  const SizedBox(width: 6),
                  FilterChip(label: const Text("Location"), onSelected: (_) {}),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                "Events",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              EventItem(
                imageUrl: "assets/jpg/bright.jpg",
                title: "Brightlight Music Festival",
                subtitle: "DaboQ Concert Hall - Friday Oct 24, 9PM",
                tags: "#Rock • €40 - €90",
                onTap: () {},
              ),
              EventItem(
                imageUrl: "assets/png/G&RP.png",
                title: "Guns & Roses Metal Festival",
                subtitle: " - Wednesday Oct 22, 12PM",
                tags: "#Metal • €180",
                onTap: () {},
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Show all 5 events"),
              ),

              const Text(
                "Places",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              PlaceItem(
                imageUrl: "assets/jpg/concert.jpg",
                title: "DaboQ Concert Hall",
                subtitle: "Lizbonska 4, Warsaw • #Music",
                onTap: () {},
              ),
              PlaceItem(
                imageUrl: "assets/jpg/Stage.jpg",
                title: "Bright Lights Hall",
                subtitle: "Zamieniecka 8, Warsaw • #Music",
                onTap: () {},
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Show all 25 performers"),
              ),

              const Text(
                "Performers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              PerformerItem(
                imageUrl: "assets/jpg/AG.jpg",
                name: "Adam Gontier ",
                genre: "Rock",
                event: "No Next Event",
                onTap: () {},
              ),
              PerformerItem(
                imageUrl: "assets/jpg/CB.jpg",
                name: "Chester Bennington",
                genre: "Indie Rock",
                event: "Next event Friday Oct 25, 12AM",
                onTap: () {},
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Show all 25 performers"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
