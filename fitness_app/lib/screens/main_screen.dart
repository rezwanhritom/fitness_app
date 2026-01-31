import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';

/// Main screen - training space ready
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Welcome message
              Text(
                'Your training space is ready.',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Everything is set up for your fitness journey.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(height: 40),

              // Placeholder sections
              _buildPlaceholderSection(
                title: 'Today\'s Workout',
                icon: Icons.fitness_center,
                description: 'Your personalized workout will appear here',
              ),
              const SizedBox(height: 24),

              _buildPlaceholderSection(
                title: 'Progress',
                icon: Icons.trending_up,
                description: 'Track your fitness journey',
              ),
              const SizedBox(height: 24),

              _buildPlaceholderSection(
                title: 'Training Plan',
                icon: Icons.calendar_today,
                description: 'View your weekly schedule',
              ),
              const SizedBox(height: 24),

              _buildPlaceholderSection(
                title: 'Exercises',
                icon: Icons.list,
                description: 'Browse available exercises',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderSection({
    required String title,
    required IconData icon,
    required String description,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  size: 24,
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
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
