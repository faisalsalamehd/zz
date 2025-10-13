import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// Storage Service - Handles all local storage operations
/// Uses SharedPreferences for simple key-value pairs
/// Uses Hive for complex objects and cached data
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;
  Box? _cacheBox;
  Box? _userBox;
  Box? _settingsBox;
  
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Initialize storage service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      
      // Initialize Hive
      await Hive.initFlutter();
      
      // Open Hive boxes
      _cacheBox = await Hive.openBox('cache_box');
      _userBox = await Hive.openBox('user_box');
      _settingsBox = await Hive.openBox('settings_box');
      
      _isInitialized = true;
      print('✅ StorageService initialized successfully');
    } catch (e) {
      print('❌ Error initializing StorageService: $e');
      rethrow;
    }
  }

  // ==================== SharedPreferences Methods ====================
  
  /// Save string value
  Future<bool> saveString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Get string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Save integer value
  Future<bool> saveInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Get integer value
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Save boolean value
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Get boolean value
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Save double value
  Future<bool> saveDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  /// Get double value
  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// Save list of strings
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  /// Get list of strings
  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// Remove a key from SharedPreferences
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// Clear all SharedPreferences
  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }

  // ==================== Hive Cache Methods ====================
  
  /// Save data to cache
  Future<void> saveToCache(String key, dynamic value) async {
    await _cacheBox?.put(key, value);
  }

  /// Get data from cache
  dynamic getFromCache(String key, {dynamic defaultValue}) {
    return _cacheBox?.get(key, defaultValue: defaultValue);
  }

  /// Save JSON to cache
  Future<void> saveCacheJson(String key, Map<String, dynamic> json) async {
    await _cacheBox?.put(key, jsonEncode(json));
  }

  /// Get JSON from cache
  Map<String, dynamic>? getCacheJson(String key) {
    final data = _cacheBox?.get(key);
    if (data != null && data is String) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (e) {
        print('Error decoding JSON from cache: $e');
        return null;
      }
    }
    return null;
  }

  /// Delete from cache
  Future<void> deleteFromCache(String key) async {
    await _cacheBox?.delete(key);
  }

  /// Clear all cache
  Future<void> clearCache() async {
    await _cacheBox?.clear();
  }

  /// Get cache size
  int getCacheSize() {
    return _cacheBox?.length ?? 0;
  }

  // ==================== User Data Methods ====================
  
  /// Save user data
  Future<void> saveUserData(String key, dynamic value) async {
    await _userBox?.put(key, value);
  }

  /// Get user data
  dynamic getUserData(String key, {dynamic defaultValue}) {
    return _userBox?.get(key, defaultValue: defaultValue);
  }

  /// Save user as JSON
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _userBox?.put('current_user', jsonEncode(userData));
  }

  /// Get user data as JSON
  Map<String, dynamic>? getUser() {
    final data = _userBox?.get('current_user');
    if (data != null && data is String) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (e) {
        print('Error decoding user data: $e');
        return null;
      }
    }
    return null;
  }

  /// Delete user data
  Future<void> deleteUserData(String key) async {
    await _userBox?.delete(key);
  }

  /// Clear all user data
  Future<void> clearUserData() async {
    await _userBox?.clear();
  }

  // ==================== Settings Methods ====================
  
  /// Save settings
  Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox?.put(key, value);
  }

  /// Get settings
  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox?.get(key, defaultValue: defaultValue);
  }

  /// Clear all settings
  Future<void> clearSettings() async {
    await _settingsBox?.clear();
  }

  // ==================== Auth Token Methods ====================
  
  /// Save auth token
  Future<bool> saveAuthToken(String token) async {
    return await saveString('auth_token', token);
  }

  /// Get auth token
  String? getAuthToken() {
    return getString('auth_token');
  }

  /// Remove auth token
  Future<bool> removeAuthToken() async {
    return await remove('auth_token');
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return containsKey('auth_token');
  }

  // ==================== Theme Methods ====================
  
  /// Save theme mode
  Future<bool> saveThemeMode(bool isDark) async {
    return await saveBool('is_dark_mode', isDark);
  }

  /// Get theme mode
  bool isDarkMode() {
    return getBool('is_dark_mode') ?? false;
  }

  // ==================== Language Methods ====================
  
  /// Save language
  Future<bool> saveLanguage(String languageCode) async {
    return await saveString('language_code', languageCode);
  }

  /// Get language
  String getLanguage() {
    return getString('language_code') ?? 'en';
  }

  // ==================== First Time Launch ====================
  
  /// Save first time launch flag
  Future<bool> setFirstTimeLaunch(bool isFirstTime) async {
    return await saveBool('is_first_time', isFirstTime);
  }

  /// Check if first time launch
  bool isFirstTimeLaunch() {
    return getBool('is_first_time') ?? true;
  }

  // ==================== Cache with Expiry ====================
  
  /// Save data with expiry time
  Future<void> saveCacheWithExpiry(
    String key, 
    dynamic value, 
    Duration expiry,
  ) async {
    final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;
    final cacheData = {
      'value': value,
      'expiry': expiryTime,
    };
    await _cacheBox?.put(key, jsonEncode(cacheData));
  }

  /// Get cached data with expiry check
  dynamic getCacheWithExpiry(String key) {
    final data = _cacheBox?.get(key);
    if (data != null && data is String) {
      try {
        final cacheData = jsonDecode(data);
        final expiryTime = cacheData['expiry'] as int;
        final now = DateTime.now().millisecondsSinceEpoch;
        
        if (now < expiryTime) {
          return cacheData['value'];
        } else {
          // Cache expired, delete it
          deleteFromCache(key);
          return null;
        }
      } catch (e) {
        print('Error reading cache with expiry: $e');
        return null;
      }
    }
    return null;
  }

  // ==================== File Storage Methods ====================
  
  /// Get app documents directory
  Future<Directory> getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Get app cache directory
  Future<Directory> getCacheDirectory() async {
    return await getTemporaryDirectory();
  }

  /// Get app support directory
  Future<Directory> getSupportDirectory() async {
    return await getApplicationSupportDirectory();
  }

  /// Save file to documents directory
  Future<File> saveFile(String fileName, List<int> bytes) async {
    final dir = await getDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.writeAsBytes(bytes);
  }

  /// Read file from documents directory
  Future<List<int>?> readFile(String fileName) async {
    try {
      final dir = await getDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      if (await file.exists()) {
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  /// Delete file from documents directory
  Future<bool> deleteFile(String fileName) async {
    try {
      final dir = await getDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  /// Get storage info
  Future<Map<String, dynamic>> getStorageInfo() async {
    return {
      'cache_size': getCacheSize(),
      'user_data_size': _userBox?.length ?? 0,
      'settings_size': _settingsBox?.length ?? 0,
      'total_keys': _prefs?.getKeys().length ?? 0,
    };
  }

  // ==================== Cleanup Methods ====================
  
  /// Clear all app data (logout)
  Future<void> clearAllAppData() async {
    await clearAll();
    await clearCache();
    await clearUserData();
    await clearSettings();
    print('✅ All app data cleared');
  }

  /// Close all boxes (call on app dispose)
  Future<void> dispose() async {
    await _cacheBox?.close();
    await _userBox?.close();
    await _settingsBox?.close();
    await Hive.close();
  }
}
