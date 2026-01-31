/// Training profile model for program generation
class TrainingProfile {
  // Lifestyle
  final String? occupationType; // 'Sedentary', 'Moderately active', 'Physically demanding'
  final String? sleepDuration; // '<5', '5-6', '6-7', '7-8', '8+'
  final String? eatingRegularly; // 'Yes', 'Sometimes', 'Rarely'
  final String? physicallyTired; // 'Yes', 'Sometimes', 'No'

  // Training background
  final String? trainingLevel; // Required: 'Never trained before', 'Trained a little', 'Trained regularly', 'Trained a lot but stopped', 'Currently training'

  // Optional fitness self-tests
  final String? pushUps; // '0', '1-5', '6-15', '16+', "Can't do any"
  final String? sitUps; // '0', '1-10', '11-25', '26+', "Can't do any"

  TrainingProfile({
    this.occupationType,
    this.sleepDuration,
    this.eatingRegularly,
    this.physicallyTired,
    this.trainingLevel,
    this.pushUps,
    this.sitUps,
  });

  /// Check if training level is set (required field)
  bool get hasRequiredFields => trainingLevel != null && trainingLevel!.isNotEmpty;

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'occupationType': occupationType,
      'sleepDuration': sleepDuration,
      'eatingRegularly': eatingRegularly,
      'physicallyTired': physicallyTired,
      'trainingLevel': trainingLevel,
      'pushUps': pushUps,
      'sitUps': sitUps,
    };
  }

  /// Create from JSON
  factory TrainingProfile.fromJson(Map<String, dynamic> json) {
    return TrainingProfile(
      occupationType: json['occupationType'] as String?,
      sleepDuration: json['sleepDuration'] as String?,
      eatingRegularly: json['eatingRegularly'] as String?,
      physicallyTired: json['physicallyTired'] as String?,
      trainingLevel: json['trainingLevel'] as String?,
      pushUps: json['pushUps'] as String?,
      sitUps: json['sitUps'] as String?,
    );
  }

  /// Create a copy with updated fields
  TrainingProfile copyWith({
    String? occupationType,
    String? sleepDuration,
    String? eatingRegularly,
    String? physicallyTired,
    String? trainingLevel,
    String? pushUps,
    String? sitUps,
  }) {
    return TrainingProfile(
      occupationType: occupationType ?? this.occupationType,
      sleepDuration: sleepDuration ?? this.sleepDuration,
      eatingRegularly: eatingRegularly ?? this.eatingRegularly,
      physicallyTired: physicallyTired ?? this.physicallyTired,
      trainingLevel: trainingLevel ?? this.trainingLevel,
      pushUps: pushUps ?? this.pushUps,
      sitUps: sitUps ?? this.sitUps,
    );
  }
}
