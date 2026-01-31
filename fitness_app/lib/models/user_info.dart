/// User information model with BMI calculation
class UserInfo {
  final int age;
  final String sex; // 'Male', 'Female', or 'Prefer not to say'
  final double height; // in cm
  final double weight; // in kg

  UserInfo({
    required this.age,
    required this.sex,
    required this.height,
    required this.weight,
  });

  /// Calculate BMI silently in the background
  /// BMI = weight (kg) / (height (m))^2
  double get bmi {
    if (height <= 0) return 0.0;
    final heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'sex': sex,
      'height': height,
      'weight': weight,
    };
  }

  /// Create from JSON
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      age: json['age'] as int,
      sex: json['sex'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
    );
  }

  /// Create a copy with updated fields
  UserInfo copyWith({
    int? age,
    String? sex,
    double? height,
    double? weight,
  }) {
    return UserInfo(
      age: age ?? this.age,
      sex: sex ?? this.sex,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
