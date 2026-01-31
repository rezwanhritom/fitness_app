import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_info.dart';
import '../models/training_profile.dart';

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

  // Training Profile Storage
  static const String _trainingProfileKey = 'training_profile';

  /// Save training profile to local storage
  static Future<bool> saveTrainingProfile(TrainingProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(profile.toJson());
      return await prefs.setString(_trainingProfileKey, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// Retrieve training profile from local storage
  static Future<TrainingProfile?> getTrainingProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_trainingProfileKey);
      if (jsonString == null) return null;
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return TrainingProfile.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Check if training profile exists
  static Future<bool> hasTrainingProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_trainingProfileKey);
  }

  /// Clear training profile
  static Future<bool> clearTrainingProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_trainingProfileKey);
    } catch (e) {
      return false;
    }
  }
}
