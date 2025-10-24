import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zz/firebase_options.dart';
import 'package:zz/routes/routes.dart';
import 'package:zz/utils/connectivity_service.dart';
import 'package:zz/utils/storage_service.dart';
import 'package:zz/utils/storage_manager.dart';
import 'package:zz/widgets/connection_widgets.dart';

// Global navigator key for accessing context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Initialize Storage Service
  await StorageService().initialize();
  
  
  // Initialize Connectivity Service
  await ConnectivityService().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final StorageManager _storageManager = StorageManager();
  bool _hasConnection = true;
  late Stream<bool> _connectionStream;

  @override
  void initState() {
    super.initState();
    _connectionStream = _connectivityService.connectionStream;
    _hasConnection = _connectivityService.hasConnection;
    
    // Listen to connectivity changes
    _connectionStream.listen((bool hasConnection) {
      if (mounted) {
        setState(() {
          _hasConnection = hasConnection;
        });
        
        // Show connection status notification
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && context.mounted) {
            showConnectionSnackbar(context, hasConnection);
          }
        });
        
        // Sync offline data when connection is restored
        if (hasConnection) {
          _storageManager.syncOfflineData();
        }
      }
    });
    
    // Listen to sync status
    _storageManager.syncStatusStream.listen((status) {
      if (mounted) {
        _handleSyncStatus(status);
      }
    });
  }

  void _handleSyncStatus(SyncStatus status) {
    String message = '';
    Color backgroundColor = Colors.blue;
    
    switch (status) {
      case SyncStatus.syncing:
        message = 'Syncing offline data...';
        backgroundColor = Colors.orange;
        break;
      case SyncStatus.completed:
        message = 'Sync completed successfully';
        backgroundColor = Colors.green;
        break;
      case SyncStatus.failed:
        message = 'Some items failed to sync';
        backgroundColor = Colors.red;
        break;
      case SyncStatus.idle:
        return; // Don't show anything for idle
    }
    
    if (message.isNotEmpty && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (status == SyncStatus.syncing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (status != SyncStatus.syncing)
                Icon(
                  status == SyncStatus.completed ? Icons.check_circle : Icons.error,
                  color: Colors.white,
                  size: 20,
                ),
              const SizedBox(width: 8),
              Text(message),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Add global navigator key
      debugShowCheckedModeBanner: false,
      routes: routes,
      builder: (context, child) {
        return ConnectionStatusOverlay(
          showConnectionLost: !_hasConnection,
          onRetry: () async {
            await _connectivityService.checkConnectivity();
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    _storageManager.dispose();
    super.dispose();
  }
}
