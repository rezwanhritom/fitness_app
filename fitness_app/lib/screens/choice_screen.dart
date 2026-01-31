import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';
import '../navigation/app_router.dart';
import '../services/user_storage_service.dart';
import '../services/program_generator_service.dart';
import '../models/training_profile.dart';

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
                onTap: () async {
                  // Generate basic program and navigate to main
                  await _generateBasicProgramAndNavigate(context);
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

  Future<void> _generateBasicProgramAndNavigate(BuildContext context) async {
    try {
      // Get user info
      final userInfo = await UserStorageService.getUserInfo();
      if (userInfo == null) {
        // Should not happen, but handle gracefully
        Navigator.of(context).pushNamed(AppRouter.exercises);
        return;
      }

      // Create minimal training profile with default values
      final basicProfile = TrainingProfile(
        trainingLevel: 'Never trained before', // Conservative default
      );

      // Generate program with conservative defaults
      final programConfig = ProgramGeneratorService.generateProgram(
        userInfo: userInfo,
        profile: basicProfile,
      );

      // Save program configuration
      await UserStorageService.saveProgramConfig(programConfig);

      // Navigate to main screen
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.main);
      }
    } catch (e) {
      // On error, just navigate to exercises screen
      if (context.mounted) {
        Navigator.of(context).pushNamed(AppRouter.exercises);
      }
    }
  }
}
