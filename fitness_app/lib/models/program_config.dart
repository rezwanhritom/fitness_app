/// Program configuration model for training plan
class ProgramConfig {
  final String capabilityLevel; // 'Beginner', 'Intermediate', 'Advanced'
  final String trainingVolume; // 'Low', 'Moderate', 'High'
  final String trainingIntensity; // 'Low', 'Moderate', 'High'
  final List<String> allowedCategories; // Exercise categories allowed

  ProgramConfig({
    required this.capabilityLevel,
    required this.trainingVolume,
    required this.trainingIntensity,
    required this.allowedCategories,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'capabilityLevel': capabilityLevel,
      'trainingVolume': trainingVolume,
      'trainingIntensity': trainingIntensity,
      'allowedCategories': allowedCategories,
    };
  }

  /// Create from JSON
  factory ProgramConfig.fromJson(Map<String, dynamic> json) {
    return ProgramConfig(
      capabilityLevel: json['capabilityLevel'] as String,
      trainingVolume: json['trainingVolume'] as String,
      trainingIntensity: json['trainingIntensity'] as String,
      allowedCategories: (json['allowedCategories'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }
}
