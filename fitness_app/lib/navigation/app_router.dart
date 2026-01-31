import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import 'package:flutter/material.dart';

/// App routing constants and navigation paths
class AppRouter {
  // Route names
  static const String splash = '/';
  static const String home = '/home';
  
  // Private constructor to prevent instantiation
  AppRouter._();
  
  /// Generate routes for the app
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}
