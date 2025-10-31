import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String _address = 'Fetching location...';

  String? activeSort;
  String? activeCuisine;
  bool ratingAbove4 = false;

  List<Map<String, dynamic>> restaurants = [
    {
      "image": "assets/png/JSF.png",
      "name": "Junior Seafood, Jumeirah 3",
      "cuisines": ["Thai", "International", "Continental"],
      "rating": 4.4,
      "time": "41 mins",
      "delivery": "USD 7.50",
    },
    {
      "image": "assets/jpeg/SC.jpeg",
      "name": "Sushi Counter, Business Bay 4",
      "cuisines": ["Sushi", "Japanese", "Seafood"],
      "rating": 4.7,
      "time": "35 mins",
      "delivery": "USD 5.50",
    },
    {
      "image": "assets/png/P2G.png",
      "name": "Pizza 2 Go",
      "cuisines": ["Italian", "Pasta", "Pizza"],
      "rating": 4.5,
      "time": "40 mins",
      "delivery": "USD 7.00",
    },
    {
      "image": "assets/png/Papparoti.png",
      "name": "Papparoti",
      "cuisines": ["Beverages", "Arabic sweets", "Dessert"],
      "rating": 4.4,
      "time": "29 mins",
      "delivery": "USD 5.50",
    },
    {
      "image": "assets/png/malaklogo.png",
      "name": "Malak Al Tawouk",
      "cuisines": ["Lebanese", "Shawarma"],
      "rating": 4.7,
      "time": "30 mins",
      "delivery": "USD 6.50",
    },
    {
      "image": "assets/jpg/pokelogo.jpg",
      "name": "Poke & Co",
      "cuisines": ["Poke", "Healthy"],
      "rating": 4.5,
      "time": "35 mins",
      "delivery": "USD 7.00",
    },
    {
      "image": "assets/png/healthyCo.png",
      "name": "Healthy Corner",
      "cuisines": ["Healthy"],
      "rating": 4.6,
      "time": "32 mins",
      "delivery": "USD 6.00",
    },
    {
      "image": "assets/png/pizzahut.png",
      "name": "Pizza Hut",
      "cuisines": ["Italian", "Pizza", "International"],
      "rating": 4.5,
      "time": "38 mins",
      "delivery": "USD 7.50",
    },
    {
      "image": "assets/png/Aldayaa.png",
      "name": "Al Dayaa",
      "cuisines": ["Middle Eastern"],
      "rating": 5.0,
      "time": "25 mins",
      "delivery": "USD 5.00",
    },
    {
      "image": "assets/png/Subway.png",
      "name": "Subway",
      "cuisines": ["Sandwiches,Healthy", "International"],
      "rating": 5.0,
      "time": "25 mins",
      "delivery": "USD 8.00",
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    return restaurants.where((restaurant) {
      final matchesCuisine =
          activeCuisine == null ||
          (restaurant["cuisines"] as List<String>).contains(activeCuisine);
      final matchesRating = !ratingAbove4 || restaurant["rating"] >= 4.0;
      return matchesCuisine && matchesRating;
    }).toList()..sort((a, b) {
      if (activeSort == "Rating") {
        return (b["rating"] as double).compareTo(a["rating"] as double);
      } else if (activeSort == "Price: low - High") {
        double priceA =
            double.tryParse(
              (a["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        double priceB =
            double.tryParse(
              (b["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        return priceA.compareTo(priceB);
      } else if (activeSort == "Price: High - low") {
        double priceA =
            double.tryParse(
              (a["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        double priceB =
            double.tryParse(
              (b["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        return priceB.compareTo(priceA);
      }
      return 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _address = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() {
          _address = 'Location permission denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() {
        _address = 'Location permissions are permanently denied';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (!mounted) return;
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      setState(() {
        _address =
            '${placemark.locality ?? placemark.subAdministrativeArea}, ${placemark.street ?? ''}';
      });
    } else {
      setState(() {
        _address = 'Unknown location';
      });
    }
  }

  void _showFilterOptions(String type) {
    List<String> options = [];
    switch (type) {
      case "Sort by":
        options = ["Rating", "Price: low - High", "Price: High - low"];
        break;
      case "Cuisines":
        options = [
          "Italian",
          "Middle Eastern",
          "Japanese",
          "Thai",
          "Healthy",
          "International",
          "Dessert",
        ];
        break;
      case "Rating 4.0+":
        options = ["4.0+"];
        break;
    }

    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: options
            .map(
              (e) => ListTile(
                title: Text(e),
                onTap: () {
                  setState(() {
                    if (type == "Sort by") {
                      activeSort = activeSort == e ? null : e;
                    } else if (type == "Cuisines") {
                      activeCuisine = activeCuisine == e ? null : e;
                    } else if (type == "Rating 4.0+") {
                      ratingAbove4 = !ratingAbove4;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivering to",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              _address,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            const SizedBox(height: 16),
            _buildPromoBanners(),
            const SizedBox(height: 20),
            _buildGreatValueDeals(),
            const SizedBox(height: 20),
            const Text(
              "All restaurants",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(filteredRestaurants.length * 2 - 1, (index) {
              if (index.isEven) {
                final restaurant = filteredRestaurants[index ~/ 2];
                return _restaurantTile(
                  restaurant["image"] as String,
                  restaurant["name"] as String,
                  (restaurant["cuisines"] as List<String>).join(", "),
                  restaurant["rating"] as double,
                  restaurant["time"] as String,
                  restaurant["delivery"] as String,
                );
              } else {
                return Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 156, 156, 156),
                      height: 1.1,
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip("Sort by"),
          _filterChip("Cuisines"),
          _filterChip("Rating 4.0+"),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    bool isSelected = false;

    if (label == "Sort by") {
      isSelected = activeSort != null;
    } else if (label == "Cuisines") {
      isSelected = activeCuisine != null;
    } else if (label == "Rating 4.0+") {
      isSelected = ratingAbove4;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.grey.shade200,
        onSelected: (_) => _showFilterOptions(label),
      ),
    );
  }

  Widget _buildPromoBanners() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _promoCard(
            "Super\n Saver",
            Colors.blue,
            imagePath: "assets/png/50%.png",
          ),
          _promoCard(
            "Best Sellers",
            Colors.blue,
            imagePath: "assets/png/30%.png",
          ),
          _promoCard(
            "talabat Pro",
            Colors.blue,
            imagePath: "assets/png/Tpro.png",
          ),
          _promoCard(
            "Must-tries",
            Colors.blue,
            imagePath: "assets/png/MTs.png",
          ),
        ],
      ),
    );
  }

  Widget _buildGreatValueDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Great value deals",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _dealCard(
                "assets/png/malak.png",
                "Malak Al Tawouk",
                "Lebanese, Shawarma",
                4.7,
              ),
              _dealCard(
                "assets/png/Poke.png",
                "Poke & Co",
                "Poke, Healthy",
                4.5,
              ),
              _dealCard(
                "assets/jpg/healthy.jpg",
                "Healthy Corner",
                "Healthy",
                4.6,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _promoCard(String title, Color color, {String? imagePath}) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null && imagePath.isNotEmpty)
                Image.asset(
                  imagePath,
                  height: 70,
                  width: 70,
                  fit: BoxFit.contain,
                ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 66, 66, 66),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _dealCard(
    String image,
    String name,
    String desc,
    double rating,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 100,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.orange),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _restaurantTile(
    String image,
    String name,
    String desc,
    double rating,
    String time,
    String price,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 20, color: Colors.orange),
                    Text(" $rating ", style: const TextStyle(fontSize: 12)),
                    const Icon(Icons.timer, size: 20, color: Colors.grey),
                    Text(" $time ", style: const TextStyle(fontSize: 12)),
                    const Icon(
                      Icons.attach_money,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Text(price, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Talabat Mart Screen --------------------
class TalabatMartScreen extends StatefulWidget {
  const TalabatMartScreen({super.key});

  @override
  State<TalabatMartScreen> createState() => _TalabatMartScreenState();
}

class _TalabatMartScreenState extends State<TalabatMartScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _address = 'Fetching location...';
  String? activeSort;
  String? activeCuisine;
  bool ratingAbove4 = false;

  List<Map<String, dynamic>> restaurants = [
    {
      "image": "assets/png/Subway.png",
      "name": "Subway",
      "cuisines": ["Sandwiches,Healthy", "International"],
      "rating": 5.0,
      "time": "25 mins",
      "delivery": "USD 8.00",
    },
    // Add more restaurants here
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    return restaurants.where((restaurant) {
      final matchesCuisine =
          activeCuisine == null ||
          (restaurant["cuisines"] as List<String>).contains(activeCuisine);
      final matchesRating = !ratingAbove4 || restaurant["rating"] >= 4.0;
      return matchesCuisine && matchesRating;
    }).toList()..sort((a, b) {
      if (activeSort == "Rating") {
        return (b["rating"] as double).compareTo(a["rating"] as double);
      } else if (activeSort == "Price: low - High") {
        double priceA =
            double.tryParse(
              (a["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        double priceB =
            double.tryParse(
              (b["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        return priceA.compareTo(priceB);
      } else if (activeSort == "Price: High - low") {
        double priceA =
            double.tryParse(
              (a["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        double priceB =
            double.tryParse(
              (b["delivery"] as String).replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
        return priceB.compareTo(priceA);
      }
      return 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _address = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() {
          _address = 'Location permission denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() {
        _address = 'Location permissions are permanently denied';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (!mounted) return;
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      setState(() {
        _address =
            '${placemark.locality ?? placemark.subAdministrativeArea}, ${placemark.street ?? ''}';
      });
    } else {
      setState(() {
        _address = 'Unknown location';
      });
    }
  }

  void _showFilterOptions(String type) {
    List<String> options = [];
    switch (type) {
      case "Sort by":
        options = ["Rating", "Price: low - High", "Price: High - low"];
        break;
      case "Cuisines":
        options = [
          "Italian",
          "Middle Eastern",
          "Japanese",
          "Thai",
          "Healthy",
          "International",
          "Dessert",
        ];
        break;
      case "Rating 4.0+":
        options = ["4.0+"];
        break;
    }

    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: options
            .map(
              (e) => ListTile(
                title: Text(e),
                onTap: () {
                  setState(() {
                    if (type == "Sort by") {
                      activeSort = activeSort == e ? null : e;
                    } else if (type == "Cuisines") {
                      activeCuisine = activeCuisine == e ? null : e;
                    } else if (type == "Rating 4.0+") {
                      ratingAbove4 = !ratingAbove4;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivering to",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              _address,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            const SizedBox(height: 16),
            _buildPromoBanners(),
            const SizedBox(height: 20),
            _buildGreatValueDeals(),
            const SizedBox(height: 20),
            _buildCategories(),
            const SizedBox(height: 16),
            const Text(
              "All restaurants",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(filteredRestaurants.length * 2 - 1, (index) {
              if (index.isEven) {
                final restaurant = filteredRestaurants[index ~/ 2];
                return _restaurantTile(
                  restaurant["image"] as String,
                  restaurant["name"] as String,
                  (restaurant["cuisines"] as List<String>).join(", "),
                  restaurant["rating"] as double,
                  restaurant["time"] as String,
                  restaurant["delivery"] as String,
                );
              } else {
                return Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 156, 156, 156),
                      height: 1.1,
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Container(
        color: Colors.white,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for ...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      "Fruit & Veg",
      "Milk & Yogurts",
      "Cheese & Butter",
      "Bakery",
      "Poultry, Eggs, & Deli",
      "Sweet Snacks",
      "Biscuits & Wafers",
      "Salted Snacks",
      "Nuts and Seeds",
      "Beverages",
      "Ice Cream",
      "View all categories",
    ];

    return SizedBox(
      width: 500,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _filterTile(categories[index]);
        },
      ),
    );
  }

  Widget _filterTile(String label) {
    final Map<String, String> chipImages = {
      "Fruit & Veg": "assets/png/vig.png",
      "Milk & Yogurts": "assets/png/milk.png",
      "Cheese & Butter": "assets/png/chese.png",
      "Bakery": "assets/png/bakery.png",
      "Poultry, Eggs, & Deli": "assets/png/poultry.png",
      "Sweet Snacks": "assets/png/sweets.png",
      "Biscuits & Wafers": "assets/png/biscuits.png",
      "Salted Snacks": "assets/png/salted.png",
      "Nuts and Seeds": "assets/png/nuts.png",
      "Beverages": "assets/png/beverages.png",
      "Ice Cream": "assets/png/icecream.png",
      "View all categories": "assets/png/Tab 3.png",
    };

    return GestureDetector(
      onTap: () {
        if (label == "View all categories") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllCategoriesScreen(
                categories: chipImages.keys
                    .where((key) => key != "View all categories")
                    .toList(),
              ),
            ),
          );
        } else {
          final items = _getCategoryItems(label);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryScreen(categoryName: label, items: items),
            ),
          );
        }
      },
      child: Column(
        children: [
          if (chipImages.containsKey(label))
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                chipImages[label]!,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getCategoryItems(String category) {
    final items = {
      "Fruit & Veg": [
        {
          "name": "Bananas",
          "imagePath": "assets/png/banana.png",
          "price": "\$2.50",
        },
        {
          "name": "Tomatoes",
          "imagePath": "assets/png/tomato.png",
          "price": "\$3.00",
        },
      ],
      "Milk & Yogurts": [
        {
          "name": "Fresh Milk",
          "imagePath": "assets/png/milk.png",
          "price": "\$1.50",
        },
        {
          "name": "Greek Yogurt",
          "imagePath": "assets/png/yogurt.png",
          "price": "\$2.20",
        },
      ],
      "Bakery": [
        {
          "name": "Bread",
          "imagePath": "assets/png/bread.png",
          "price": "\$1.20",
        },
        {
          "name": "Croissant",
          "imagePath": "assets/png/croissant.png",
          "price": "\$2.00",
        },
      ],
      // add all other categories here
    };

    return items[category] ?? [];
  }

  // -------------------- Promo & Deals --------------------
  Widget _buildPromoBanners() {
    return SizedBox(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _promoCard(
            "Today’s\n Best Deals",
            Colors.blue,
            imagePath: "assets/png/TS.png",
          ),
          _promoCard(
            "Everyday \n Discounts",
            Colors.blue,
            imagePath: "assets/png/EDD.png",
          ),
          _promoCard("Imported", Colors.blue, imagePath: "assets/png/IM.png"),
          _promoCard("4", Colors.blue, imagePath: "assets/png/.png"),
          _promoCard("5", Colors.blue, imagePath: "assets/png/.png"),
        ],
      ),
    );
  }

  Widget _buildGreatValueDeals() {
    final restaurants = [
      {
        'name': 'Galaxy Chocolate',
        'subtitle': 'Smooth Milk Chocolate',
        'imagePath': 'assets/png/choclate.png',
        'price': '7.55 ',
      },
      {
        'name': 'Kiri Creamy',
        'subtitle': 'TubCheese 200 g',
        'imagePath': 'assets/png/kiri.png',
        'price': '36.40',
      },
      {
        'name': 'Prince Sandwich',
        'subtitle': 'Biscuit with Choclate',
        'imagePath': 'assets/png/Pchoco.png',
        'price': '3.25 ',
      },
      {
        'name': 'Kiri Creamy',
        'subtitle': 'TubCheese 100 g',
        'imagePath': 'assets/png/kiri.png',
        'price': '19.70 ',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trending now 🔥',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final r = restaurants[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          r['imagePath']!,
                          width: 120,
                          height: 110,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        r['name']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        r['subtitle']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        r['price'] != null ? '\$ ${r['price']}' : '',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _restaurantTile(
    String image,
    String name,
    String desc,
    double rating,
    String time,
    String price,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    Text(" $rating ", style: const TextStyle(fontSize: 12)),
                    const Icon(Icons.timer, size: 16, color: Colors.grey),
                    Text(" $time ", style: const TextStyle(fontSize: 12)),
                    const Icon(
                      Icons.attach_money,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(price, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoCard(String title, Color color, {String? imagePath}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          margin: const EdgeInsets.only(right: 8),
          child: Center(
            child: imagePath != null && imagePath.isNotEmpty
                ? Image.asset(imagePath, height: 120, fit: BoxFit.cover)
                : const SizedBox(),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 66, 66, 66),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// -------------------- Category Screen --------------------
class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, String>> items;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: items.isEmpty
          ? const Center(child: Text("No items in this category"))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          item["imagePath"]!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item["price"]!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// -------------------- All Categories Screen --------------------
class AllCategoriesScreen extends StatelessWidget {
  final List<String> categories;
  const AllCategoriesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: const Icon(Icons.category, color: Colors.orange),
            title: Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // navigate to CategoryScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    categoryName: category,
                    items: _getCategoryItems(category),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Map<String, String>> _getCategoryItems(String category) {
    final items = {
      "Fruit & Veg": [
        {
          "name": "Bananas",
          "imagePath": "assets/png/banana.png",
          "price": "\$2.50",
        },
        {
          "name": "Tomatoes",
          "imagePath": "assets/png/tomato.png",
          "price": "\$3.00",
        },
      ],
      "Milk & Yogurts": [
        {
          "name": "Fresh Milk",
          "imagePath": "assets/png/milk.png",
          "price": "\$1.50",
        },
        {
          "name": "Greek Yogurt",
          "imagePath": "assets/png/yogurt.png",
          "price": "\$2.20",
        },
      ],
      "Bakery": [
        {
          "name": "Bread",
          "imagePath": "assets/png/bread.png",
          "price": "\$1.20",
        },
        {
          "name": "Croissant",
          "imagePath": "assets/png/croissant.png",
          "price": "\$2.00",
        },
      ],
      // add all other categories here
    };
    return items[category] ?? [];
  }
}

// Groceries Screen
class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groceries'),
        backgroundColor: Color(0xFF9C27B0),
        foregroundColor: Colors.white,
      ),
      body: _buildCategoryScreen(
        title: 'Groceries',
        subtitle: 'Fresh fruits, vegetables, and daily essentials',
        icon: Icons.shopping_bag,
        color: Color(0xFF9C27B0),
        imageUrl:
            'https://via.placeholder.com/200x200/9C2  7B0/FFFFFF?text=🛍️',
      ),
    );
  }
}

// Health & Wellness Screen
class HealthWellnessScreen extends StatelessWidget {
  const HealthWellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health & Wellness'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: _buildCategoryScreen(
        title: 'Health & Wellness',
        subtitle: 'Medicines, supplements, and health products',
        icon: Icons.medical_services,
        color: Color(0xFF2196F3),
        imageUrl: 'https://via.placeholder.com/200x200/2196F3/FFFFFF?text=💊',
      ),
    );
  }
}

// Flowers Screen
class FlowersScreen extends StatelessWidget {
  const FlowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowers'),
        backgroundColor: Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: _buildCategoryScreen(
        title: 'Flowers',
        subtitle: 'Beautiful flowers for every occasion',
        icon: Icons.local_florist,
        color: Color(0xFFE91E63),
        imageUrl: 'https://via.placeholder.com/200x200/E91E63/FFFFFF?text=🌸',
      ),
    );
  }
}

// Coffee Screen
class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee'),
        backgroundColor: Color(0xFF795548),
        foregroundColor: Colors.white,
      ),
      body: _buildCategoryScreen(
        title: 'Coffee',
        subtitle: 'Premium coffee and beverages delivered fresh',
        icon: Icons.coffee,
        color: Color(0xFF795548),
        imageUrl: 'https://via.placeholder.com/200x200/795548/FFFFFF?text=☕',
      ),
    );
  }
}

// More Shops Screen
class MoreShopsScreen extends StatelessWidget {
  const MoreShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Shops'),
        backgroundColor: Color(0xFF607D8B),
        foregroundColor: Colors.white,
      ),
      body: _buildCategoryScreen(
        title: 'More Shops',
        subtitle: 'Discover more stores and categories',
        icon: Icons.apps,
        color: Color(0xFF607D8B),
        imageUrl: 'https://via.placeholder.com/200x200/607D8B/FFFFFF?text=⊞',
      ),
    );
  }
}

// Shared Category Screen Widget
Widget _buildCategoryScreen({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required String imageUrl,
}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(icon, color: color, size: 60);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Content Section
        Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "This category is under development. We're working hard to bring you the best ${title.toLowerCase()} experience.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24),

              // Feature list
              _buildFeatureItem(
                icon: Icons.check_circle,
                text: 'Wide selection of quality products',
                color: color,
              ),
              _buildFeatureItem(
                icon: Icons.check_circle,
                text: 'Fast and reliable delivery',
                color: color,
              ),
              _buildFeatureItem(
                icon: Icons.check_circle,
                text: 'Competitive prices',
                color: color,
              ),
              _buildFeatureItem(
                icon: Icons.check_circle,
                text: '24/7 customer support',
                color: color,
              ),

              SizedBox(height: 32),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('$title will be available soon!'),
                    //     backgroundColor: color,
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Get Notified',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFeatureItem({
  required IconData icon,
  required String text,
  required Color color,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}
