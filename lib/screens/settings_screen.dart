import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zz/routes/routes_strings.dart';
import 'package:zz/wel.dart';
import 'country_selection_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? firebaseUser;
  String selectedCountry = "UAE"; // default for guests
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    firebaseUser = FirebaseAuth.instance.currentUser;
    _checkNotificationStatus();
  }

  Future<void> _checkNotificationStatus() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .getNotificationSettings();
    setState(() {
      notificationsEnabled =
          settings.authorizationStatus == AuthorizationStatus.authorized;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await FirebaseMessaging.instance.subscribeToTopic("all");
        setState(() => notificationsEnabled = true);
      }
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("all");
      setState(() => notificationsEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = firebaseUser != null;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                          value: notificationsEnabled,
                          activeColor: Colors.orange,
                          activeTrackColor: Colors.orange.withOpacity(0.5),
                          inactiveThumbColor: Colors.grey.shade400,
                          inactiveTrackColor: Colors.grey.shade300,
                          onChanged: _toggleNotifications,
                        ),
                      ],
                    ),
                  ),
                  Container(height: 16, color: Colors.grey[200]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: _buildSettingsItem(
                      title: "Language",
                      value: "English",
                      onTap: () {},
                    ),
                  ),
                  Container(height: 4, color: Colors.grey[200]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: _buildSettingsItem(
                      title: "Country",
                      value: selectedCountry,
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CountrySelectionScreen(
                              currentCountry: selectedCountry,
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() => selectedCountry = result);
                        }
                      },
                    ),
                  ),
                  Container(height: 16, color: Colors.grey[200]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: _buildSettingsItem(
                      title: loggedIn ? "Log out" : "Log in",
                      value: "",
                      onTap: () async {
                        if (loggedIn) {
                          await FirebaseAuth.instance.signOut();
                          // 🔹 Navigate to WelcomeScreen after logout
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const Welcome()),
                            (route) => false,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesStrings.login,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
