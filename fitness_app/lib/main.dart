import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(const FitnessApp());
}

/// Main app widget with dark-mode-first theme and navigation
class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      // Dark mode as default
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      // Navigation setup
      initialRoute: AppRouter.splash,
      routes: AppRouter.getRoutes(),
    );
  }
}
