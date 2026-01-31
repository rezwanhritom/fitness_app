import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';
import '../models/training_profile.dart';
import '../services/user_storage_service.dart';
import '../navigation/app_router.dart';

/// Multi-step training plan setup questionnaire
class TrainingPlanSetupScreen extends StatefulWidget {
  const TrainingPlanSetupScreen({super.key});

  @override
  State<TrainingPlanSetupScreen> createState() => _TrainingPlanSetupScreenState();
}

class _TrainingPlanSetupScreenState extends State<TrainingPlanSetupScreen> {
  int _currentStep = 0;
  TrainingProfile _profile = TrainingProfile();
  bool _isSaving = false;

  // Total number of steps
  static const int _totalSteps = 7;

  // Step titles
  final List<String> _stepTitles = [
    'Lifestyle',
    'Lifestyle',
    'Lifestyle',
    'Lifestyle',
    'Training Background',
    'Fitness Test (Optional)',
    'Fitness Test (Optional)',
  ];

  // Questions
  final List<String> _questions = [
    'What is your occupation type?',
    'What is your average sleep duration?',
    'Do you eat regularly most days?',
    'Do you feel physically tired most days?',
    'What is your training level?',
    'How many push-ups can you do?',
    'How many sit-ups can you do?',
  ];

  // Options for each question
  final List<List<String>> _options = [
    ['Sedentary', 'Moderately active', 'Physically demanding'],
    ['<5', '5–6', '6–7', '7–8', '8+'],
    ['Yes', 'Sometimes', 'Rarely'],
    ['Yes', 'Sometimes', 'No'],
    [
      'Never trained before',
      'Trained a little',
      'Trained regularly',
      'Trained a lot but stopped',
      'Currently training',
    ],
    ['0', '1–5', '6–15', '16+', "Can't do any"],
    ['0', '1–10', '11–25', '26+', "Can't do any"],
  ];

  // Field names for each step
  final List<String?> _fieldNames = [
    'occupationType',
    'sleepDuration',
    'eatingRegularly',
    'physicallyTired',
    'trainingLevel',
    'pushUps',
    'sitUps',
  ];

  bool get _canProceed {
    // Training level (step 4, index 4) is required
    if (_currentStep == 4) {
      return _profile.trainingLevel != null && _profile.trainingLevel!.isNotEmpty;
    }
    // All other steps are optional, can always proceed
    return true;
  }

  void _selectOption(String option) {
    setState(() {
      switch (_currentStep) {
        case 0:
          _profile = _profile.copyWith(occupationType: option);
          break;
        case 1:
          _profile = _profile.copyWith(sleepDuration: option);
          break;
        case 2:
          _profile = _profile.copyWith(eatingRegularly: option);
          break;
        case 3:
          _profile = _profile.copyWith(physicallyTired: option);
          break;
        case 4:
          _profile = _profile.copyWith(trainingLevel: option);
          break;
        case 5:
          _profile = _profile.copyWith(pushUps: option);
          break;
        case 6:
          _profile = _profile.copyWith(sitUps: option);
          break;
      }
    });
  }

  String? _getSelectedValue() {
    switch (_currentStep) {
      case 0:
        return _profile.occupationType;
      case 1:
        return _profile.sleepDuration;
      case 2:
        return _profile.eatingRegularly;
      case 3:
        return _profile.physicallyTired;
      case 4:
        return _profile.trainingLevel;
      case 5:
        return _profile.pushUps;
      case 6:
        return _profile.sitUps;
      default:
        return null;
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _saveAndComplete();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _skipStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _saveAndComplete();
    }
  }

  Future<void> _saveAndComplete() async {
    if (!_canProceed && _currentStep == 4) {
      // Show message that training level is required
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your training level to continue.'),
          backgroundColor: AppColors.tertiary,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final saved = await UserStorageService.saveTrainingProfile(_profile);
      if (saved && mounted) {
        // Navigate to home or next screen
        Navigator.of(context).pushReplacementNamed(AppRouter.home);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOptional = _currentStep != 4; // Training level is required
    final isLastStep = _currentStep == _totalSteps - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _stepTitles[_currentStep],
          style: AppTypography.heading3,
        ),
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of $_totalSteps',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.tertiary,
                        ),
                      ),
                      if (isOptional)
                        TextButton(
                          onPressed: _skipStep,
                          child: Text(
                            'Skip',
                            style: AppTypography.buttonMedium.copyWith(
                              color: AppColors.tertiary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / _totalSteps,
                    backgroundColor: AppColors.surfaceVariant,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    minHeight: 4,
                  ),
                ],
              ),
            ),

            // Question and options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Question
                    Text(
                      _questions[_currentStep],
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.onBackground,
                      ),
                    ),
                    if (isOptional && _currentStep >= 5) // Fitness tests
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'This is optional. You can skip if you prefer.',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.tertiary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),

                    // Options
                    ..._options[_currentStep].map((option) {
                      final isSelected = _getSelectedValue() == option;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildOptionCard(
                          option: option,
                          isSelected: isSelected,
                          onTap: () => _selectOption(option),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: Text(
                          'Back',
                          style: AppTypography.buttonLarge,
                        ),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    flex: _currentStep == 0 ? 1 : 2,
                    child: ElevatedButton(
                      onPressed: (_canProceed || isOptional) && !_isSaving
                          ? (isLastStep ? _saveAndComplete : _nextStep)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        disabledBackgroundColor: AppColors.surfaceVariant,
                        disabledForegroundColor: AppColors.tertiary,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.onPrimary,
                                ),
                              ),
                            )
                          : Text(
                              isLastStep ? 'Complete' : 'Next',
                              style: AppTypography.buttonLarge.copyWith(
                                color: (_canProceed || isOptional) && !_isSaving
                                    ? AppColors.onPrimary
                                    : AppColors.tertiary,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option,
                style: AppTypography.bodyLarge.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.onBackground,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
