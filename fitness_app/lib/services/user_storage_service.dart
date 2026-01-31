import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_info.dart';

/// Service for storing and retrieving user information locally
class UserStorageService {
  static const String _userInfoKey = 'user_info';

  /// Save user information to local storage
  static Future<bool> saveUserInfo(UserInfo userInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(userInfo.toJson());
      return await prefs.setString(_userInfoKey, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// Retrieve user information from local storage
  static Future<UserInfo?> getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userInfoKey);
      if (jsonString == null) return null;
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserInfo.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Check if user information exists
  static Future<bool> hasUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userInfoKey);
  }

  /// Clear user information
  static Future<bool> clearUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_userInfoKey);
    } catch (e) {
      return false;
    }
  }
}
