import '../models/user_info.dart';
import '../models/training_profile.dart';
import '../models/program_config.dart';

/// Deterministic logic service for generating training program
class ProgramGeneratorService {
  /// Generate program configuration based on user data
  static ProgramConfig generateProgram({
    required UserInfo userInfo,
    required TrainingProfile profile,
  }) {
    // Calculate capability level
    final capabilityLevel = _calculateCapabilityLevel(
      userInfo: userInfo,
      profile: profile,
    );

    // Calculate training volume (conservative defaults)
    final trainingVolume = _calculateTrainingVolume(
      capabilityLevel: capabilityLevel,
      profile: profile,
    );

    // Calculate training intensity
    final trainingIntensity = _calculateTrainingIntensity(
      capabilityLevel: capabilityLevel,
      profile: profile,
    );

    // Determine allowed exercise categories
    final allowedCategories = _determineAllowedCategories(
      capabilityLevel: capabilityLevel,
      userInfo: userInfo,
      profile: profile,
    );

    return ProgramConfig(
      capabilityLevel: capabilityLevel,
      trainingVolume: trainingVolume,
      trainingIntensity: trainingIntensity,
      allowedCategories: allowedCategories,
    );
  }

  /// Calculate user capability level
  static String _calculateCapabilityLevel({
    required UserInfo userInfo,
    required TrainingProfile profile,
  }) {
    double score = 0.0;

    // Training level (most important factor)
    switch (profile.trainingLevel) {
      case 'Never trained before':
        score += 0;
        break;
      case 'Trained a little':
        score += 1;
        break;
      case 'Trained regularly':
        score += 3;
        break;
      case 'Trained a lot but stopped':
        score += 2;
        break;
      case 'Currently training':
        score += 4;
        break;
    }

    // Fitness test results (if available)
    if (profile.pushUps != null && profile.pushUps != "Can't do any") {
      switch (profile.pushUps) {
        case '0':
          score += 0;
          break;
        case '1–5':
          score += 1;
          break;
        case '6–15':
          score += 2;
          break;
        case '16+':
          score += 3;
          break;
      }
    }

    if (profile.sitUps != null && profile.sitUps != "Can't do any") {
      switch (profile.sitUps) {
        case '0':
          score += 0;
          break;
        case '1–10':
          score += 1;
          break;
        case '11–25':
          score += 2;
          break;
        case '26+':
          score += 3;
          break;
      }
    }

    // Lifestyle factors (negative modifiers for conservative approach)
    if (profile.physicallyTired == 'Yes') {
      score -= 1;
    }
    if (profile.sleepDuration == '<5' || profile.sleepDuration == '5–6') {
      score -= 1;
    }
    if (profile.eatingRegularly == 'Rarely') {
      score -= 1;
    }

    // Age factor (conservative for older users)
    if (userInfo.age > 50) {
      score -= 1;
    } else if (userInfo.age > 40) {
      score -= 0.5;
    }

    // BMI factor (conservative for very high BMI)
    if (userInfo.bmi > 30) {
      score -= 1;
    }

    // Capability level assignment (conservative defaults)
    if (score <= 1.0) {
      return 'Beginner';
    } else if (score <= 4.0) {
      return 'Intermediate';
    } else {
      return 'Advanced';
    }
  }

  /// Calculate training volume (conservative, beginner-friendly)
  static String _calculateTrainingVolume({
    required String capabilityLevel,
    required TrainingProfile profile,
  }) {
    // Conservative defaults - start low
    switch (capabilityLevel) {
      case 'Beginner':
        return 'Low';
      case 'Intermediate':
        // Check lifestyle factors
        if (profile.occupationType == 'Sedentary' &&
            profile.physicallyTired == 'Yes') {
          return 'Low';
        }
        return 'Moderate';
      case 'Advanced':
        // Still conservative, check lifestyle
        if (profile.physicallyTired == 'Yes' ||
            profile.sleepDuration == '<5' ||
            profile.sleepDuration == '5–6') {
          return 'Moderate';
        }
        return 'High';
      default:
        return 'Low'; // Safe default
    }
  }

  /// Calculate training intensity
  static String _calculateTrainingIntensity({
    required String capabilityLevel,
    required TrainingProfile profile,
  }) {
    switch (capabilityLevel) {
      case 'Beginner':
        return 'Low';
      case 'Intermediate':
        if (profile.physicallyTired == 'Yes') {
          return 'Low';
        }
        return 'Moderate';
      case 'Advanced':
        if (profile.physicallyTired == 'Yes' ||
            profile.sleepDuration == '<5') {
          return 'Moderate';
        }
        return 'High';
      default:
        return 'Low'; // Safe default
    }
  }

  /// Determine allowed exercise categories
  static List<String> _determineAllowedCategories({
    required String capabilityLevel,
    required UserInfo userInfo,
    required TrainingProfile profile,
  }) {
    final categories = <String>[];

    // All capability levels get basic categories
    categories.add('Strength');
    categories.add('Flexibility');
    categories.add('Mobility');

    // Intermediate and Advanced get more
    if (capabilityLevel != 'Beginner') {
      categories.add('Cardio');
      categories.add('Endurance');
    }

    // Advanced only
    if (capabilityLevel == 'Advanced') {
      categories.add('Power');
      categories.add('Plyometric');
    }

    // Safety restrictions based on age and BMI
    if (userInfo.age > 50 || userInfo.bmi > 30) {
      // Remove high-impact categories
      categories.remove('Plyometric');
      if (userInfo.age > 60) {
        categories.remove('Power');
      }
    }

    // Remove high-impact for low capability users
    if (capabilityLevel == 'Beginner') {
      categories.remove('Plyometric');
      categories.remove('Power');
    }

    // If physically tired, remove high-intensity categories
    if (profile.physicallyTired == 'Yes') {
      categories.remove('Plyometric');
      categories.remove('Power');
      if (capabilityLevel == 'Beginner') {
        categories.remove('Cardio');
      }
    }

    // Ensure at least basic categories
    if (categories.isEmpty) {
      categories.addAll(['Strength', 'Flexibility', 'Mobility']);
    }

    return categories;
  }
}
