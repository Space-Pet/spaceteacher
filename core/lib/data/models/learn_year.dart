class LearnYear {
  String preLearnYear;
  String currentLearnYear;
  String nextLearnYear;

  LearnYear({
    required this.preLearnYear,
    required this.currentLearnYear,
    required this.nextLearnYear,
  });

  factory LearnYear.fromJson(Map<String, dynamic> json) {
    return LearnYear(
      preLearnYear: json['pre_learn_year'],
      currentLearnYear: json['current_learn_year'],
      nextLearnYear: json['next_learn_year'],
    );
  }

  factory LearnYear.fromMap(Map<String, dynamic> map) {
    return LearnYear(
      preLearnYear: map['pre_learn_year'] as String,
      currentLearnYear: map['current_learn_year'] as String,
      nextLearnYear: map['next_learn_year'] as String,
    );
  }

  factory LearnYear.empty() {
    return LearnYear(
      preLearnYear: '',
      currentLearnYear: '',
      nextLearnYear: '',
    );
  }

  List<String> toList() {
    // check empty or null
    if (preLearnYear.isEmpty ||
        currentLearnYear.isEmpty ||
        nextLearnYear.isEmpty) {
      return [];
    }

    return [preLearnYear, currentLearnYear, nextLearnYear];
  }
}
