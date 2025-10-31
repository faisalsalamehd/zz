import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zz/routes/routes_strings.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (_isConnected && mounted) {
        _checkAuthAndNavigate();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
      return;
    }
    if (!mounted) return;
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      _isConnected =
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);
    });
  }

  void _checkAuthAndNavigate() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Logged in → go to home
      Navigator.pushReplacementNamed(context, RoutesStrings.home);
    } else {
      // Guest → go to account
      Navigator.pushReplacementNamed(context, RoutesStrings.accountint);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 97, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            Image.asset("assets/png/talabat.png"),
            const SizedBox(height: 16),
            Text(
              _isConnected
                  ? "Checking authentication..."
                  : "Checking connection...",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
