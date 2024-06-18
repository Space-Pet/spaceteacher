part of 'score_bloc.dart';

class ScoreState extends Equatable {
  const ScoreState({
    required this.programList,
    required this.scoreProgram,
    required this.txtLearnYear,
    this.isPrimaryStudent = false,
    this.txtHocKy = TermType.term1,
    this.txtTihHocKy = PrimaryTermType.midTerm1,
    required this.moetTypeScore,
    required this.moetAverage,
    //
    required this.eslScore,
    required this.primaryConduct,
    this.status = ScoreStatus.initial,
    this.programListStatus = ScoreProgramStatus.initial,
    this.conducStatus = ScoreStatus.initial,
  });

  final List<ScoreProgram> programList;
  final ScoreProgram scoreProgram;
  final String txtLearnYear;
  final bool isPrimaryStudent;

  final TermType txtHocKy;
  final PrimaryTermType txtTihHocKy;

  final ScoreModel moetTypeScore;
  final MoetAverage moetAverage;

  //

  final EslScore eslScore;
  final PrimaryConduct primaryConduct;

  final ScoreProgramStatus programListStatus;
  final ScoreStatus status;
  final ScoreStatus conducStatus;

  @override
  List<Object?> get props => [
        programList,
        scoreProgram,
        txtLearnYear,
        isPrimaryStudent,
        txtHocKy,
        txtTihHocKy,
        moetAverage,
        //
        moetTypeScore,
        primaryConduct,
        status,
        programListStatus,
        conducStatus,
      ];

  static String _calculateYearRange() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int previousYear = currentYear - 1;
    return '$previousYear-$currentYear';
  }

  ScoreState copyWith({
    List<ScoreProgram>? programList,
    ScoreProgram? scoreProgram,
    String? txtLearnYear,
    bool? isPrimaryStudent,
    TermType? txtHocKy,
    PrimaryTermType? txtTihHocKy,
    MoetAverage? moetAverage,
    //
    ScoreModel? moetTypeScore,
    EslScore? eslScore,
    PrimaryConduct? primaryConduct,
    List<String>? yearList,
    ScoreStatus? status,
    ScoreProgramStatus? programListStatus,
    ScoreStatus? conducStatus,
  }) {
    return ScoreState(
      programList: programList ?? this.programList,
      scoreProgram: scoreProgram ?? this.scoreProgram,
      txtLearnYear: txtLearnYear ?? this.txtLearnYear,
      isPrimaryStudent: isPrimaryStudent ?? this.isPrimaryStudent,
      txtHocKy: txtHocKy ?? this.txtHocKy,
      txtTihHocKy: txtTihHocKy ?? this.txtTihHocKy,
      moetAverage: moetAverage ?? this.moetAverage,
      //
      moetTypeScore: moetTypeScore ?? this.moetTypeScore,
      eslScore: eslScore ?? this.eslScore,
      primaryConduct: primaryConduct ?? this.primaryConduct,
      status: status ?? this.status,
      programListStatus: programListStatus ?? this.programListStatus,
      conducStatus: conducStatus ?? this.conducStatus,
    );
  }
}

enum ScoreStatus { initial, loading, loaded, error }

enum ScoreProgramStatus { initial, loading, loaded, error }

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

enum FilterType {
  program,
  term,
  learnYear,
}

extension FilterTypeX on FilterType {
  String value() {
    switch (this) {
      case FilterType.program:
        return 'program';
      case FilterType.term:
        return 'term';
      default:
        return 'learnYear';
    }
  }
}
