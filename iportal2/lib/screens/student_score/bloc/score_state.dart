part of 'score_bloc.dart';

class ScoreState extends Equatable {
  ScoreState({
    required this.scoreData,
    required this.userKey,
    String? txtHocKy,
    String? txtLearnYear,
    String? scoreType,
  })  : txtHocKy = txtHocKy ?? '1',
        scoreType = scoreType ?? ScoreType.monet.text(),
        txtLearnYear = txtLearnYear ?? _calculateYearRange();

  final ScoreResData scoreData;
  final String userKey;
  final String? txtHocKy;
  final String? txtLearnYear;
  final String? scoreType;

  @override
  List<Object?> get props =>
      [scoreType, scoreData, userKey, txtHocKy, txtLearnYear];

  static String _calculateYearRange() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int previousYear = currentYear - 1;
    return '$previousYear-$currentYear';
  }

  ScoreState copyWith({
    ScoreResData? scoreData,
    List<String>? yearList,
    String? userKey,
    String? txtHocKy,
    String? txtLearnYear,
    String? scoreType,
  }) {
    return ScoreState(
      scoreType: scoreType ?? this.scoreType,
      scoreData: scoreData ?? this.scoreData,
      userKey: userKey ?? this.userKey,
      txtHocKy: txtHocKy ?? this.txtHocKy,
      txtLearnYear: txtLearnYear ?? this.txtLearnYear,
    );
  }
}
