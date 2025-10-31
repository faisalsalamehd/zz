import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _address = 'Fetching location...';

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

    if (!mounted) return; // 🔹 Check if widget is still in the tree
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              SizedBox(height: 16),
              _buildCategoriesGrid(context),
              SizedBox(height: 16),
              _buildPromoSection(),
              _buildShortcutsSection(),
              _buildAdvertisementBanner(),
              _buildPopularRestaurants(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE5D9), Color(0xFFFFF4E6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section: Delivery Address
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering to',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _address,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bottom Section: Greeting + Image
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey there!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Let us be careful of discounts for a better ordering experience',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset('assets/png/hi.png', fit: BoxFit.contain),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      {
        'title': 'Food',
        'icon': Icons.restaurant,
        'color': Color(0xFFFF6B35),
        'route': '/food',
        'imagePath': 'assets/png/foodIcon.png',
      },
      {
        'title': 'Talabat\nmart',
        'icon': Icons.shopping_cart,
        'color': Color(0xFF4CAF50),
        'route': '/talabat-mart',
        'imagePath': 'assets/png/martIcon.png',
      },
      {
        'title': 'Groceries',
        'icon': Icons.shopping_bag,
        'color': Color(0xFF9C27B0),
        'route': '/groceries',
        'imagePath': 'assets/png/groceriesIcon.png',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, category['route'] as String),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      category['imagePath'] as String,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category['title'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.confirmation_number, color: Color(0xFFFF6B35)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Got a code?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Add your promo code here',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildShortcutsSection() {
    final shortcuts = [
      {
        'icon': Icons.receipt_long,
        'label': 'Past orders',
        'color': Color(0xFFFF6B35),
      },
      {'icon': Icons.star, 'label': 'Super saves', 'color': Color(0xFFFFD700)},
      {'icon': Icons.store, 'label': 'Multi-tries', 'color': Color(0xFF4CAF50)},
      {'icon': Icons.refresh, 'label': 'Give Back', 'color': Color(0xFF2196F3)},
      {
        'icon': Icons.stars,
        'label': 'Best Sellers',
        'color': Color(0xFFE91E63),
      },
    ];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shortcuts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: shortcuts
                .map(
                  (s) => Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (s['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          s['icon'] as IconData,
                          color: s['color'] as Color,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        s['label'] as String,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvertisementBanner() {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/png/M&Ms.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPopularRestaurants() {
    final restaurants = [
      {
        'name': 'Allo Beirut',
        'subtitle': '4 stars',
        'imagePath': 'assets/png/AlloBeirut.png',
      },
      {
        'name': 'Laffe\'n',
        'subtitle': '4.5 stars',
        'imagePath': 'assets/png/laffeh.png',
      },
      {
        'name': 'Falafil AlRabiah Al khadraa',
        'subtitle': '4.2 stars',
        'imagePath': 'assets/png/falafel.png',
      },
      {
        'name': 'Barbar',
        'subtitle': '4.8 stars',
        'imagePath': 'assets/png/Barbar.png',
      },
    ];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular restaurants nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final r = restaurants[index];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          r['imagePath']!,
                          width: 92,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        r['name']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        r['subtitle']!,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
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
}
