import 'package:json_annotation/json_annotation.dart';

part 'learn_year_payment.g.dart';

@JsonSerializable()
class LearnYearPayment {
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'current_learn_year')
  final int? currentLearnYear;

  LearnYearPayment({this.learnYear, this.currentLearnYear});

  factory LearnYearPayment.fromJson(Map<String, dynamic> json) =>
      _$LearnYearPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$LearnYearPaymentToJson(this);

  @override
  String toString() {
    return 'LearnYearPayment{learnYear: $learnYear, currentLearnYear: $currentLearnYear}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearnYearPayment &&
          runtimeType == other.runtimeType &&
          learnYear == other.learnYear &&
          currentLearnYear == other.currentLearnYear;

  @override
  int get hashCode => learnYear.hashCode ^ currentLearnYear.hashCode;

  LearnYearPayment copyWith({
    String? learnYear,
    int? currentLearnYear,
  }) {
    return LearnYearPayment(
      learnYear: learnYear ?? this.learnYear,
      currentLearnYear: currentLearnYear ?? this.currentLearnYear,
    );
  }
}
