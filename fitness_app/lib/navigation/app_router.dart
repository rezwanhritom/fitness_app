import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/motivation_screen.dart';
import '../screens/user_info_setup_screen.dart';
import '../screens/choice_screen.dart';
import '../screens/training_plan_setup_screen.dart';
import '../screens/exercises_screen.dart';
import 'package:flutter/material.dart';

/// App routing constants and navigation paths
class AppRouter {
  // Route names
  static const String splash = '/';
  static const String motivation = '/motivation';
  static const String userInfoSetup = '/user-info-setup';
  static const String choice = '/choice';
  static const String trainingPlanSetup = '/training-plan-setup';
  static const String exercises = '/exercises';
  static const String home = '/home';
  
  // Private constructor to prevent instantiation
  AppRouter._();
  
  /// Generate routes for the app
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      motivation: (context) => const MotivationScreen(),
      userInfoSetup: (context) => const UserInfoSetupScreen(),
      choice: (context) => const ChoiceScreen(),
      trainingPlanSetup: (context) => const TrainingPlanSetupScreen(),
      exercises: (context) => const ExercisesScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}
