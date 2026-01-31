import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';
import '../models/user_info.dart';
import '../services/user_storage_service.dart';
import '../navigation/app_router.dart';

/// User information setup screen with form validation
class UserInfoSetupScreen extends StatefulWidget {
  const UserInfoSetupScreen({super.key});

  @override
  State<UserInfoSetupScreen> createState() => _UserInfoSetupScreenState();
}

class _UserInfoSetupScreenState extends State<UserInfoSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  
  String? _selectedSex;
  bool _isLoading = false;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _ageController.text.isNotEmpty &&
        _selectedSex != null &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _formKey.currentState?.validate() == true;
  }

  Future<void> _handleContinue() async {
    if (!_isFormValid) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userInfo = UserInfo(
        age: int.parse(_ageController.text),
        sex: _selectedSex!,
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
      );

      // Calculate BMI (silently in background)
      final bmi = userInfo.bmi;

      // Store locally
      final saved = await UserStorageService.saveUserInfo(userInfo);
      
      if (saved && mounted) {
        // Navigate to choice screen
        Navigator.of(context).pushReplacementNamed(AppRouter.choice);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save information. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please check your entries.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Your Information',
          style: AppTypography.heading3,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Explanation text
                Text(
                  'We use this to keep training safe and realistic',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
                const SizedBox(height: 40),

                // Age section
                _buildSectionLabel('Age'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your age',
                    suffixText: 'years',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is required';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 150) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 32),

                // Sex section
                _buildSectionLabel('Sex'),
                const SizedBox(height: 12),
                _buildSexSelector(),
                const SizedBox(height: 32),

                // Height section
                _buildSectionLabel('Height'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your height',
                    suffixText: 'cm',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Height is required';
                    }
                    final height = double.tryParse(value);
                    if (height == null || height < 50 || height > 300) {
                      return 'Please enter a valid height (50-300 cm)';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 32),

                // Weight section
                _buildSectionLabel('Weight'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your weight',
                    suffixText: 'kg',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Weight is required';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 20 || weight > 500) {
                      return 'Please enter a valid weight (20-500 kg)';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 48),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isFormValid && !_isLoading ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      disabledBackgroundColor: AppColors.surfaceVariant,
                      disabledForegroundColor: AppColors.tertiary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
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
                            'Continue',
                            style: AppTypography.buttonLarge.copyWith(
                              color: _isFormValid
                                  ? AppColors.onPrimary
                                  : AppColors.tertiary,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: AppTypography.heading4.copyWith(
        color: AppColors.onBackground,
      ),
    );
  }

  Widget _buildSexSelector() {
    final options = ['Male', 'Female', 'Prefer not to say'];
    
    return Column(
      children: options.map((option) {
        final isSelected = _selectedSex == option;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedSex = option;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.surface : AppColors.surface,
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
          ),
        );
      }).toList(),
    );
  }
}
