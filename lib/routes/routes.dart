import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zz/userinteractions.dart';

// Screens
import 'package:zz/wel.dart';
import 'package:zz/login.dart';
import 'package:zz/signup.dart';
import 'package:zz/forgetpass.dart';
import 'package:zz/screens/settings_screen.dart';
import 'package:zz/screens/country_selection_screen.dart';
import 'package:zz/screens/home_screen.dart';
import 'package:zz/screens/search_screen.dart';
import 'package:zz/screens/account_screen.dart';
import 'package:zz/screens/category_screens.dart';

// Route strings
import 'package:zz/routes/routes_strings.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.splash: (context) => const Welcome(),
  RoutesStrings.welcome: (context) => const Welcome(),
  RoutesStrings.login: (context) => Login(),
  RoutesStrings.signup: (context) => Signup(),
  RoutesStrings.account: (context) => const AccountScreen(),
  RoutesStrings.accountint: (context) => const accountint(),

  RoutesStrings.forgetPassword: (context) => forgetpass(),
  RoutesStrings.home: (context) => const HomeWrapper(),
  RoutesStrings.countrySelection: (context) =>
      CountrySelectionScreen(currentCountry: ''),
  RoutesStrings.settings: (context) => const SettingsScreen(),
  RoutesStrings.food: (context) => FoodScreen(),
  RoutesStrings.talabatMart: (context) => TalabatMartScreen(),
  RoutesStrings.groceries: (context) => GroceriesScreen(),
  RoutesStrings.healthWellness: (context) => HealthWellnessScreen(),
  RoutesStrings.flowers: (context) => FlowersScreen(),
  RoutesStrings.coffee: (context) => CoffeeScreen(),
  RoutesStrings.moreShops: (context) => MoreShopsScreen(),
};

/// HomeWrapper with bottom navigation
class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0; // Home tab by default

  final List<Widget> _screens = [HomeScreen(), SearchScreen(), AccountScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
