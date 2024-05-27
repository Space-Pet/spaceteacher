part of 'score_bloc.dart';

class ScoreState extends Equatable {
  const ScoreState({
    required this.moetScore,
    required this.eslScore,
    required this.primaryConduct,
    required this.txtLearnYear,
    required this.otherScore,
    this.txtHocKy = TermType.term1,
    this.txtTihHocKy = PrimaryTermType.midTerm1,
    this.scoreType = 'Điểm MOET',
    this.status = ScoreStatus.initial,
    this.otherScoreStatus = OtherScoreStatus.initial,
    this.conducStatus = ScoreStatus.initial,
  });

  final ScoreModel moetScore;
  final EslScore eslScore;
  final PrimaryConduct primaryConduct;
  final ScoreOther otherScore;

  final TermType txtHocKy;
  final PrimaryTermType txtTihHocKy;

  final String txtLearnYear;
  final String scoreType;

  final ScoreStatus status;
  final OtherScoreStatus otherScoreStatus;
  final ScoreStatus conducStatus;

  @override
  List<Object?> get props => [
        scoreType,
        moetScore,
        primaryConduct,
        otherScore,
        txtHocKy,
        txtTihHocKy,
        txtLearnYear,
        scoreType,
        status,
        otherScoreStatus,
        conducStatus,
      ];

  static String _calculateYearRange() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int previousYear = currentYear - 1;
    return '$previousYear-$currentYear';
  }

  ScoreState copyWith({
    ScoreModel? moetScore,
    EslScore? eslScore,
    PrimaryConduct? primaryConduct,
    ScoreOther? otherScore,
    List<String>? yearList,
    TermType? txtHocKy,
    PrimaryTermType? txtTihHocKy,
    String? txtLearnYear,
    String? scoreType,
    ScoreStatus? status,
    OtherScoreStatus? otherScoreStatus,
    ScoreStatus? conducStatus,
  }) {
    return ScoreState(
      scoreType: scoreType ?? this.scoreType,
      moetScore: moetScore ?? this.moetScore,
      eslScore: eslScore ?? this.eslScore,
      primaryConduct: primaryConduct ?? this.primaryConduct,
      otherScore: otherScore ?? this.otherScore,
      txtHocKy: txtHocKy ?? this.txtHocKy,
      txtTihHocKy: txtTihHocKy ?? this.txtTihHocKy,
      txtLearnYear: txtLearnYear ?? this.txtLearnYear,
      status: status ?? this.status,
      otherScoreStatus: otherScoreStatus ?? this.otherScoreStatus,
      conducStatus: conducStatus ?? this.conducStatus,
    );
  }
}

enum ScoreStatus { initial, loading, loaded, error }

enum OtherScoreStatus { initial, loading, loaded, error }

enum PrimaryTermType {
  midTerm1,
  term1,
  midTerm2,
  term2,
}

extension PrimaryTermTypeX on PrimaryTermType {
  String text() {
    switch (this) {
      case PrimaryTermType.midTerm1:
        return "Giữa học kỳ 1";
      case PrimaryTermType.term1:
        return "Cuối học kỳ 1";
      case PrimaryTermType.midTerm2:
        return "Giữa học kỳ 2";
      default:
        return "Cuối năm";
    }
  }

  int getValue() {
    switch (this) {
      case PrimaryTermType.midTerm1:
        return 1;
      case PrimaryTermType.term1:
        return 2;
      case PrimaryTermType.midTerm2:
        return 3;
      default:
        return 4;
    }
  }
}

enum TermType {
  term1,
  term2,
}

extension TermTypeX on TermType {
  String text() {
    switch (this) {
      case TermType.term1:
        return "Học kỳ 1";
      case TermType.term2:
        return "Học kỳ 2";
      default:
        return "Cuối kỳ";
    }
  }

  String getValue() {
    switch (this) {
      case TermType.term1:
        return "1";
      case TermType.term2:
        return "2";
      default:
        return "3";
    }
  }
}

enum ScoreType {
  moet,
  esl,
  // other,
  // oic,
}

extension ScoreTypeX on ScoreType {
  String text() {
    switch (this) {
      case ScoreType.moet:
        return "Điểm MOET";
      case ScoreType.esl:
        return "Điểm ESL";
      default:
        return "Điểm MOET";
    }
  }
}

enum TermCountType {
  first,
  second,
}

extension TermcountTypeX on TermCountType {
  String text() {
    switch (this) {
      case TermCountType.first:
        return "Học kỳ 1";
      case TermCountType.second:
        return "Học kỳ 2";
      default:
        return "Học kỳ 1";
    }
  }
}
