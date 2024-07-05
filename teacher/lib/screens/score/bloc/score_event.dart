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
  ScoreFilterChange({
    required this.scoreFilter,
    required this.isMOET,
    required this.type,
    required this.isMOETCheck,
    required this.ctId,
  });

  final ViewScoreSelectedParam scoreFilter;
  final String type;
  final String isMOET;
  final bool isMOETCheck;
  final String ctId;

  List<Object> get props => [scoreFilter, type, isMOET, isMOETCheck, ctId];
}

class ScoreFilterSemester extends ScoreEvent {
  final String subjectType;
  ScoreFilterSemester({
    required this.subjectType,
  });
}

/////////tab giảng dạy

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

//// get list student
class GetListStudent extends ScoreEvent {
  final int classId;
  GetListStudent({
    required this.classId,
  });
}

///get teacher detail
class GetTeacherDetail extends ScoreEvent {}

/// get ESL
class GetEslScore extends ScoreEvent {
  final String userKey;
  final String txtTerm;
  final String txtYear;
  GetEslScore({
    required this.userKey,
    required this.txtTerm,
    required this.txtYear,
  });
}

class ScoreFetchProgramList extends ScoreEvent {
  final String userKey;
  ScoreFetchProgramList({
    required this.userKey,
  });
}

class GetClassLeader extends ScoreEvent {
  final String learnYear;
  GetClassLeader({required this.learnYear});
}

class ScoreFetchMoetType extends ScoreEvent {
  final String userKey;
  final String learnYear;
  final String txtHocKy;
  final String ctId;
  final bool isMOETCheck;
  ScoreFetchMoetType({
    required this.isMOETCheck,
    required this.ctId,
    required this.learnYear,
    required this.txtHocKy,
    required this.userKey,
  });
}

class EditScore extends ScoreEvent {
  final bool edit;
  EditScore({required this.edit});
}

class ScoreFetchPrimaryConduct extends ScoreEvent {
  final String userKey;
  final String txtHocKy;
  final String hkTihValue;
  final String txtYear;
  ScoreFetchPrimaryConduct({
    required this.hkTihValue,
    required this.txtYear,
    required this.txtHocKy,
    required this.userKey,
  });
}

class GetLearnYear extends ScoreEvent {}

class PostCommentMoet extends ScoreEvent {
  final String userKey;
  final int pupilId;
  final int subjectId;
  final String commnetContent;
  final String learnYear;
  final String hkTihValue;
  PostCommentMoet({
    required this.commnetContent,
    required this.hkTihValue,
    required this.learnYear,
    required this.pupilId,
    required this.subjectId,
    required this.userKey,
  });
}

class ScoreFetchMoetAverage extends ScoreEvent {
  final String userkey;
  final String learnYear;
  final int txtHocKy;
  ScoreFetchMoetAverage({
    required this.learnYear,
    required this.txtHocKy,
    required this.userkey,
  });
}

class GetMarkType extends ScoreEvent {
  final String subjectType;
  final String capDaoTao;
  final int classId;
  GetMarkType({
    required this.capDaoTao,
    required this.classId,
    required this.subjectType,
  });
}

class SelectYear extends ScoreEvent {
  final String txtLearnYear;
  SelectYear({
    required this.txtLearnYear,
  });
}
