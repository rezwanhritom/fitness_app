import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';

/// Training plan setup screen placeholder
class TrainingPlanSetupScreen extends StatelessWidget {
  const TrainingPlanSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Training Plan Setup',
          style: AppTypography.heading3,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Training Plan Setup',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'This screen will be implemented in a future step.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
