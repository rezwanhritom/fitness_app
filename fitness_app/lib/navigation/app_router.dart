import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/motivation_screen.dart';
import '../screens/user_info_setup_screen.dart';
import 'package:flutter/material.dart';

/// App routing constants and navigation paths
class AppRouter {
  // Route names
  static const String splash = '/';
  static const String motivation = '/motivation';
  static const String userInfoSetup = '/user-info-setup';
  static const String home = '/home';
  
  // Private constructor to prevent instantiation
  AppRouter._();
  
  /// Generate routes for the app
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      motivation: (context) => const MotivationScreen(),
      userInfoSetup: (context) => const UserInfoSetupScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}
