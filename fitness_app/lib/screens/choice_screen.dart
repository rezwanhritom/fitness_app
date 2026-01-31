import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';
import '../navigation/app_router.dart';

/// Choice screen after user info setup
class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                'What would you like to do?',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Set up training plan option
              _buildChoiceCard(
                context: context,
                title: 'Set up a training plan',
                icon: Icons.calendar_today,
                onTap: () {
                  // Navigate to training plan setup (placeholder for now)
                  Navigator.of(context).pushNamed(AppRouter.trainingPlanSetup);
                },
              ),
              const SizedBox(height: 16),

              // Go straight to exercises option
              _buildChoiceCard(
                context: context,
                title: 'Go straight to exercises',
                icon: Icons.fitness_center,
                onTap: () {
                  // Navigate to exercises (placeholder for now)
                  Navigator.of(context).pushNamed(AppRouter.exercises);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTypography.heading4.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.tertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
