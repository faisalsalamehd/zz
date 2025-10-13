import 'dart:async';
import 'storage_service.dart';
import 'connectivity_service.dart';

class StorageManager {
  static final StorageManager _instance = StorageManager._internal();
  factory StorageManager() => _instance;
  StorageManager._internal();

  final StorageService _storage = StorageService();
  final ConnectivityService _connectivity = ConnectivityService();
  
  final StreamController<SyncStatus> _syncStatusController = 
      StreamController<SyncStatus>.broadcast();
  
  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;
  
  List<Map<String, dynamic>> _offlineQueue = [];
  bool _isSyncing = false;

  /// Initialize storage manager
  Future<void> initialize() async {
    await _storage.initialize();
    await _loadOfflineQueue();

    _connectivity.connectionStream.listen((hasConnection) {
      if (hasConnection && _offlineQueue.isNotEmpty) {
        syncOfflineData();
      }
    });
    
    print('✅ StorageManager initialized');
  }

  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _storage.saveUser(profile);
    await _storage.saveString('user_id', profile['id']?.toString() ?? '');
    await _storage.saveString('user_name', profile['name']?.toString() ?? '');
    await _storage.saveString('user_email', profile['email']?.toString() ?? '');
    print('✅ User profile saved');
  }

  /// Get user profile
  Map<String, dynamic>? getUserProfile() {
    return _storage.getUser();
  }

  /// Update user profile field
  Future<void> updateUserProfile(String key, dynamic value) async {
    final profile = getUserProfile() ?? {};
    profile[key] = value;
    await saveUserProfile(profile);
  }

  /// Get user ID
  String? getUserId() {
    return _storage.getString('user_id');
  }

  /// Get user name
  String? getUserName() {
    return _storage.getString('user_name');
  }

  /// Get user email
  String? getUserEmail() {
    return _storage.getString('user_email');
  }

  // ==================== Authentication Management ====================
  
  /// Login user
  Future<void> loginUser({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    await _storage.saveAuthToken(token);
    await saveUserProfile(userData);
    await _storage.setFirstTimeLaunch(false);
    print('✅ User logged in');
  }

  /// Logout user
  Future<void> logoutUser() async {
    await _storage.removeAuthToken();
    await _storage.clearUserData();
    await clearCache();
    _offlineQueue.clear();
    await _saveOfflineQueue();
    print('✅ User logged out');
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return _storage.isLoggedIn();
  }

  /// Get auth token
  String? getAuthToken() {
    return _storage.getAuthToken();
  }

  Future<void> cacheApiResponse(
    String endpoint, 
    Map<String, dynamic> data, {
    Duration expiry = const Duration(hours: 24),
  }) async {
    final cacheKey = 'api_$endpoint';
    await _storage.saveCacheWithExpiry(cacheKey, data, expiry);
    print('✅ Cached: $endpoint');
  }

  /// Get cached API response
  dynamic getCachedApiResponse(String endpoint) {
    final cacheKey = 'api_$endpoint';
    return _storage.getCacheWithExpiry(cacheKey);
  }

  /// Cache list data
  Future<void> cacheListData(
    String key, 
    List<dynamic> data, {
    Duration expiry = const Duration(hours: 12),
  }) async {
    await _storage.saveCacheWithExpiry('list_$key', data, expiry);
  }

  /// Get cached list data
  List<dynamic>? getCachedListData(String key) {
    final data = _storage.getCacheWithExpiry('list_$key');
    if (data is List) {
      return data;
    }
    return null;
  }

  /// Clear specific cache
  Future<void> clearSpecificCache(String key) async {
    await _storage.deleteFromCache(key);
  }

  /// Clear all cache
  Future<void> clearCache() async {
    await _storage.clearCache();
    print('✅ Cache cleared');
  }

  /// Get cache size
  int getCacheSize() {
    return _storage.getCacheSize();
  }

  // ==================== Offline Queue Management ====================
  
  /// Add to offline queue (for data to sync when online)
  Future<void> addToOfflineQueue({
    required String action,
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final queueItem = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'action': action, // 'POST', 'PUT', 'DELETE', etc.
      'endpoint': endpoint,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    _offlineQueue.add(queueItem);
    await _saveOfflineQueue();
    
    print('📦 Added to offline queue: $action $endpoint');
    
    // Try to sync immediately if online
    if (_connectivity.hasConnection) {
      syncOfflineData();
    }
  }

  /// Load offline queue from storage
  Future<void> _loadOfflineQueue() async {
    final data = _storage.getCacheJson('offline_queue');
    if (data != null && data['queue'] is List) {
      _offlineQueue = List<Map<String, dynamic>>.from(data['queue']);
      print('📦 Loaded ${_offlineQueue.length} items from offline queue');
    }
  }

  /// Save offline queue to storage
  Future<void> _saveOfflineQueue() async {
    await _storage.saveCacheJson('offline_queue', {
      'queue': _offlineQueue,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  /// Sync offline data when connection is available
  Future<void> syncOfflineData() async {
    if (_isSyncing || _offlineQueue.isEmpty) return;
    
    _isSyncing = true;
    _syncStatusController.add(SyncStatus.syncing);
    
    print('🔄 Starting sync of ${_offlineQueue.length} items...');
    
    final failedItems = <Map<String, dynamic>>[];
    int successCount = 0;
    
    for (var item in _offlineQueue) {
      try {
        // Here you would implement actual API calls
        // For now, we'll simulate success
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Simulate API call
        bool success = await _simulateApiCall(item);
        
        if (success) {
          successCount++;
          print('✅ Synced: ${item['action']} ${item['endpoint']}');
        } else {
          failedItems.add(item);
          print('❌ Failed to sync: ${item['action']} ${item['endpoint']}');
        }
      } catch (e) {
        failedItems.add(item);
        print('❌ Error syncing item: $e');
      }
    }
    
    _offlineQueue = failedItems;
    await _saveOfflineQueue();
    
    _isSyncing = false;
    
    if (failedItems.isEmpty) {
      _syncStatusController.add(SyncStatus.completed);
      print('✅ Sync completed: $successCount items synced');
    } else {
      _syncStatusController.add(SyncStatus.failed);
      print('⚠️ Sync completed with errors: $successCount/$successCount items synced');
    }
  }

  /// Simulate API call (replace with actual implementation)
  Future<bool> _simulateApiCall(Map<String, dynamic> item) async {
    // Replace this with actual API call logic
    // Example:
    // try {
    //   final response = await http.post(
    //     Uri.parse(item['endpoint']),
    //     body: jsonEncode(item['data']),
    //   );
    //   return response.statusCode == 200;
    // } catch (e) {
    //   return false;
    // }
    
    // Simulating success for now
    return true;
  }

  /// Get offline queue count
  int getOfflineQueueCount() {
    return _offlineQueue.length;
  }

  /// Clear offline queue
  Future<void> clearOfflineQueue() async {
    _offlineQueue.clear();
    await _saveOfflineQueue();
    print('✅ Offline queue cleared');
  }

  // ==================== Settings Management ====================
  
  /// Save app settings
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    for (var entry in settings.entries) {
      await _storage.saveSetting(entry.key, entry.value);
    }
    print('✅ Settings saved');
  }

  /// Get app settings
  Map<String, dynamic> getSettings({
    List<String> keys = const [],
  }) {
    if (keys.isEmpty) {
      return {};
    }
    
    final settings = <String, dynamic>{};
    for (var key in keys) {
      final value = _storage.getSetting(key);
      if (value != null) {
        settings[key] = value;
      }
    }
    return settings;
  }

  /// Update single setting
  Future<void> updateSetting(String key, dynamic value) async {
    await _storage.saveSetting(key, value);
  }

  /// Get single setting
  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _storage.getSetting(key, defaultValue: defaultValue);
  }

  // ==================== Theme Management ====================
  
  /// Save theme preference
  Future<void> saveTheme(bool isDark) async {
    await _storage.saveThemeMode(isDark);
  }

  /// Get theme preference
  bool isDarkMode() {
    return _storage.isDarkMode();
  }

  /// Toggle theme
  Future<void> toggleTheme() async {
    final currentTheme = isDarkMode();
    await saveTheme(!currentTheme);
  }

  // ==================== Language Management ====================
  
  /// Save language
  Future<void> saveLanguage(String languageCode) async {
    await _storage.saveLanguage(languageCode);
  }

  /// Get language
  String getLanguage() {
    return _storage.getLanguage();
  }

  // ==================== Notification Preferences ====================
  
  /// Save notification enabled state
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _storage.saveBool('notifications_enabled', enabled);
  }

  /// Check if notifications are enabled
  bool areNotificationsEnabled() {
    return _storage.getBool('notifications_enabled') ?? true;
  }

  // ==================== App State Management ====================
  
  /// Save last sync time
  Future<void> saveLastSyncTime() async {
    await _storage.saveString(
      'last_sync_time', 
      DateTime.now().toIso8601String(),
    );
  }

  /// Get last sync time
  DateTime? getLastSyncTime() {
    final timeStr = _storage.getString('last_sync_time');
    if (timeStr != null) {
      try {
        return DateTime.parse(timeStr);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Check if first time launch
  bool isFirstTimeLaunch() {
    return _storage.isFirstTimeLaunch();
  }

  /// Set first time launch completed
  Future<void> completeFirstTimeLaunch() async {
    await _storage.setFirstTimeLaunch(false);
  }

  // ==================== Storage Info ====================
  
  /// Get storage statistics
  Future<Map<String, dynamic>> getStorageInfo() async {
    final info = await _storage.getStorageInfo();
    info['offline_queue_count'] = getOfflineQueueCount();
    info['last_sync_time'] = getLastSyncTime()?.toIso8601String();
    return info;
  }

  // ==================== Cleanup ====================
  
  /// Clear all app data
  Future<void> clearAllData() async {
    await _storage.clearAllAppData();
    _offlineQueue.clear();
    print('✅ All app data cleared');
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _syncStatusController.close();
    await _storage.dispose();
  }
}

/// Sync status enum
enum SyncStatus {
  idle,
  syncing,
  completed,
  failed,
}
