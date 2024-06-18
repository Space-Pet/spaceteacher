part of 'score_bloc.dart';

sealed class ScoreEvent {}

// class ScoreFetchMoet extends ScoreEvent {
//   ScoreFetchMoet();
// }

// class ScoreFetchEsl extends ScoreEvent {
//   ScoreFetchEsl();
// }

// class ScoreFetchPrimaryConduct extends ScoreEvent {
//   ScoreFetchPrimaryConduct();
// }

class ScoreTxtTermChange extends ScoreEvent {
  ScoreTxtTermChange(this.txtHocKy);

  final String txtHocKy;

  List<Object> get props => [txtHocKy];
}

// class ScoreLearnYearChange extends ScoreEvent {
//   ScoreLearnYearChange(this.txtLearnYear);

//   final String txtLearnYear;

//   List<Object> get props => [txtLearnYear];
// }

class ScoreFilterChange extends ScoreEvent {
  ScoreFilterChange(
    this.scoreFilter,
  );

  final ViewScoreSelectedParam scoreFilter;

  List<Object> get props => [scoreFilter];
}

class ScoreFilterSemester extends ScoreEvent {}

/////////tab giảng dạy
class ScoreSemesterListClass extends ScoreEvent {
  final String capDaoTao;
  ScoreSemesterListClass({required this.capDaoTao});
}

class ClassListFetched extends ScoreEvent {}

class GetFormInputScore extends ScoreEvent {
  final int classId;
  final int subjectId;
  final String learnYear;
  final int semester;
  GetFormInputScore({
    required this.classId,
    required this.learnYear,
    required this.semester,
    required this.subjectId,
  });
  List<Object> get props => [
        classId,
        learnYear,
        semester,
        subjectId,
      ];
}
