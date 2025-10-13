import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final StreamController<bool> _connectionStreamController = StreamController<bool>.broadcast();
  
  bool _hasConnection = false;
  bool get hasConnection => _hasConnection;
  
  Stream<bool> get connectionStream => _connectionStreamController.stream;

  /// Initialize connectivity service and start listening to changes
  Future<void> initialize() async {
    // Check initial connectivity
    await _checkConnectivity();
    
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) async {
        await _checkConnectivity();
      },
    );
  }

  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final List<ConnectivityResult> connectivityResults = await _connectivity.checkConnectivity();
      
      // If no connectivity, return false
      if (connectivityResults.contains(ConnectivityResult.none)) {
        _updateConnectionStatus(false);
        return false;
      }
      
      // If we have connectivity, test actual internet connection
      bool internetConnection = await _hasInternetConnection();
      _updateConnectionStatus(internetConnection);
      return internetConnection;
    } catch (e) {
      _updateConnectionStatus(false);
      return false;
    }
  }

  /// Private method to check connectivity and update status
  Future<void> _checkConnectivity() async {
    await checkConnectivity();
  }

  /// Test actual internet connection by trying to reach a reliable host
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Update connection status and notify listeners
  void _updateConnectionStatus(bool hasConnection) {
    if (_hasConnection != hasConnection) {
      _hasConnection = hasConnection;
      _connectionStreamController.add(hasConnection);
    }
  }

  /// Get current connectivity type for display purposes
  Future<String> getConnectivityType() async {
    try {
      final List<ConnectivityResult> connectivityResults = await _connectivity.checkConnectivity();
      
      if (connectivityResults.contains(ConnectivityResult.wifi)) {
        return 'WiFi';
      } else if (connectivityResults.contains(ConnectivityResult.mobile)) {
        return 'Mobile Data';
      } else if (connectivityResults.contains(ConnectivityResult.ethernet)) {
        return 'Ethernet';
      } else {
        return 'No Connection';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Dispose of resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectionStreamController.close();
  }
}
