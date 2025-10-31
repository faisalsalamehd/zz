import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  int _selectedFilterIndex = 0;

  // Filters
  final List<FilterCategory> _filters = [
    FilterCategory('Food', Icons.restaurant_outlined, "assets/png/groc.png"),
    FilterCategory(
      'Shopping',
      Icons.shopping_bag_outlined,
      "assets/png/groc.png",
    ),
    FilterCategory(
      'Health',
      Icons.local_hospital_outlined,
      'assets/png/health.png',
    ),
    FilterCategory(
      'Gifts',
      Icons.card_giftcard_outlined,
      'assets/png/flowers.png',
    ),
    FilterCategory(
      'Deals',
      Icons.local_fire_department_outlined,
      'assets/png/moreprod.png',
    ),
  ];

  // Food: Restaurants
  final List<Restaurant> _allRestaurants = [
    Restaurant(
      name: 'Pizza Palace',
      cuisine: 'Italian',
      rating: '4.5',
      time: '20-30 min',
      imagePath: 'assets/images/pizza_palace.png',
    ),
    Restaurant(
      name: 'Burger King',
      cuisine: 'Fast Food',
      rating: '4.0',
      time: '15-25 min',
      imagePath: 'assets/images/burger_king.png',
    ),
    Restaurant(
      name: 'Sushi Express',
      cuisine: 'Japanese',
      rating: '4.7',
      time: '25-35 min',
      imagePath: 'assets/images/sushi_express.png',
    ),
    Restaurant(
      name: 'Thai Delight',
      cuisine: 'Thai',
      rating: '4.3',
      time: '20-30 min',
      imagePath: 'assets/images/thai_delight.png',
    ),
    Restaurant(
      name: 'Coffee Corner',
      cuisine: 'Cafe',
      rating: '4.2',
      time: '10-20 min',
      imagePath: 'assets/images/coffee_corner.png',
    ),
    Restaurant(
      name: 'Dessert Haven',
      cuisine: 'Desserts',
      rating: '4.6',
      time: '15-25 min',
      imagePath: 'assets/images/dessert_haven.png',
    ),
  ];

  // Shops for other filters
  final Map<String, List<Shop>> _filterShops = {
    'Shopping': [
      Shop(name: 'Grocery Mart', imagePath: 'assets/images/grocery_mart.png'),
      Shop(name: 'Daily Needs', imagePath: 'assets/images/daily_needs.png'),
    ],
    'Health': [
      Shop(name: 'Pharma Plus', imagePath: 'assets/images/pharma_plus.png'),
      Shop(
        name: 'Wellness Clinic',
        imagePath: 'assets/images/wellness_clinic.png',
      ),
    ],
    'Gifts': [
      Shop(
        name: 'Flower Boutique',
        imagePath: 'assets/images/flower_boutique.png',
      ),
    ],
    'Deals': [
      Shop(name: 'Mega Sale', imagePath: 'assets/images/mega_sale.png'),
    ],
  };

  List<Restaurant> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchResults = List.from(_allRestaurants);
  }

  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      _searchResults = _allRestaurants
          .where((r) => r.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText:
                      'Search for ${_filters[_selectedFilterIndex].name.toLowerCase()}',
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
          ),

          // Filter Buttons
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildFilterButton(index),
                );
              },
            ),
          ),

          // Content
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildFilterButton(int index) {
    final isSelected = index == _selectedFilterIndex;
    final filter = _filters[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
          _searchController.clear();
          _onSearchChanged();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 255, 97, 0)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 255, 97, 0)
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filter.icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              filter.name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final currentFilter = _filters[_selectedFilterIndex].name;

    if (currentFilter == 'Food') {
      // Food filter: show search results
      if (_searchController.text.isNotEmpty) {
        return _buildSearchResults();
      }
      return _buildFoodContent();
    } else {
      // Other filters: show shops
      return _buildShopsContent(currentFilter);
    }
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'No results found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Try searching for Pizza, Sushi, Coffee...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final restaurant = _searchResults[index];
        return _buildRestaurantCard(restaurant);
      },
    );
  }

  Widget _buildFoodContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular searches',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildPopularSearchChip('Pizza'),
              _buildPopularSearchChip('Burger'),
              _buildPopularSearchChip('Sushi'),
              _buildPopularSearchChip('Thai'),
              _buildPopularSearchChip('Coffee'),
              _buildPopularSearchChip('Dessert'),
              _buildPopularSearchChip('Shawerma'),
              _buildPopularSearchChip('Fried Chicken'),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Featured restaurants',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ..._allRestaurants.map((r) => _buildRestaurantCard(r)),
        ],
      ),
    );
  }

  Widget _buildShopsContent(String filterName) {
    final shops = _filterShops[filterName] ?? [];

    if (shops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'No shops available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Try another category or come back later',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final shop = shops[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(shop.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                shop.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopularSearchChip(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchController.text = text;
          _onSearchChanged();
        });
        FocusScope.of(context).requestFocus(_searchFocusNode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 2),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(restaurant.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  restaurant.cuisine,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Color.fromARGB(255, 255, 97, 0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.time,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
}

// Models
class FilterCategory {
  final String name;
  final IconData icon;
  final String imagePath;
  FilterCategory(this.name, this.icon, this.imagePath);
}

class Restaurant {
  final String name;
  final String cuisine;
  final String rating;
  final String time;
  final String imagePath;
  Restaurant({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.time,
    required this.imagePath,
  });
}

class Shop {
  final String name;
  final String imagePath;
  Shop({required this.name, required this.imagePath});
}
