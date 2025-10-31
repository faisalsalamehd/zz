import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'country_selection_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user;
  String countryName = 'Jordan'; // default
  String countryFlag = '🇯🇴'; // default

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Map<String, String> countryFlags = {
    'Kuwait': '🇰🇼',
    'USA': '🇺🇸',
    'Bahrain': '🇧🇭',
    'UAE': '🇦🇪',
    'Oman': '🇴🇲',
    'Qatar': '🇶🇦',
    'Jordan': '🇯🇴',
    'Egypt': '🇪🇬',
    'Iraq': '🇮🇶',
  };

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ?? 'Guest';

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    InkWell(
                      onTap: () async {
                        final selectedCountry = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CountrySelectionScreen(
                              currentCountry: countryName,
                            ),
                          ),
                        );

                        if (selectedCountry != null) {
                          setState(() {
                            countryName = selectedCountry;
                            countryFlag = countryFlags[selectedCountry] ?? '';
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.red, size: 20),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi $displayName',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '$countryFlag $countryName',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.settings, color: Colors.black),
                              onPressed: () {
                                Navigator.pushNamed(context, '/settings');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey[300]),

                    // Menu items
                    _buildMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Your orders',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.local_offer_outlined,
                      title: 'Offers',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.tablet_outlined,
                      title: 'Talabat pay',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Get help',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'About app',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
