import 'package:json_annotation/json_annotation.dart';

part 'learn_year.g.dart';

@JsonSerializable()
class LearnYear {
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'current_learn_year')
  final int? currentLearnYear;

  LearnYear({this.learnYear, this.currentLearnYear});

  factory LearnYear.fromJson(Map<String, dynamic> json) =>
      _$LearnYearFromJson(json);

  Map<String, dynamic> toJson() => _$LearnYearToJson(this);

  @override
  String toString() {
    return 'LearnYear{learnYear: $learnYear, currentLearnYear: $currentLearnYear}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearnYear &&
          runtimeType == other.runtimeType &&
          learnYear == other.learnYear &&
          currentLearnYear == other.currentLearnYear;

  @override
  int get hashCode => learnYear.hashCode ^ currentLearnYear.hashCode;

  LearnYear copyWith({
    String? learnYear,
    int? currentLearnYear,
  }) {
    return LearnYear(
      learnYear: learnYear ?? this.learnYear,
      currentLearnYear: currentLearnYear ?? this.currentLearnYear,
    );
  }
}
