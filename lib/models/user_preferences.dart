class UserPreferences {
  String? gender;
  List<String>? selectedHabits = [];
  List<String>? selectedExcercises = [];
  List<String>? selectedSports = [];
  List<String>? selectedDays = [];

  UserPreferences({
    this.gender,
    this.selectedHabits = const [],
    this.selectedExcercises = const [],
    this.selectedSports = const [],
    this.selectedDays = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'selectedHabits': selectedHabits,
      'selectedExcercises': selectedExcercises,
      'selectedSports': selectedSports,
      'selectedDays': selectedDays,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      gender: json['gender'],
      selectedHabits: List<String>.from(json['selectedHabits'] ?? []),
      selectedExcercises: List<String>.from(json['selectedExcercises'] ?? []),
      selectedSports: List<String>.from(json['selectedSports'] ?? []),
      selectedDays: List<String>.from(json['selectedDays'] ?? []),
    );
  }
}