import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';

/// Home screen placeholder
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fitness App',
          style: AppTypography.heading3,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Fitness App',
              style: AppTypography.heading2.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your fitness journey starts here',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
