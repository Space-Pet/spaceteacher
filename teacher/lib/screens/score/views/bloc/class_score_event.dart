part of 'class_score_bloc.dart';

sealed class ClassScoreEvent {}

class GetMoetPrimary extends ClassScoreEvent {
  final String subjectId;
  final String classId;
  final String semester;
  final String learnYear;
  final String capDaoTao;
  GetMoetPrimary({
    required this.capDaoTao,
    required this.classId,
    required this.learnYear,
    required this.semester,
    required this.subjectId,
  });
}

class GetMoetHigh extends ClassScoreEvent {
  final String subjectId;
  final String classId;
  final String semester;
  final String learnYear;

  GetMoetHigh({
    required this.classId,
    required this.learnYear,
    required this.semester,
    required this.subjectId,
  });
}

class ScoreSemesterListClass extends ClassScoreEvent {
  final String subjectType;
  final String capDaoTao;
  ScoreSemesterListClass({
    required this.capDaoTao,
    required this.subjectType,
  });
}

class GetStudentInputScore extends ClassScoreEvent {
  final int classId;
  GetStudentInputScore({
    required this.classId,
  });
}

class PostMOETPrimary extends ClassScoreEvent {
  final int subjectId;
  final int classId;
  final String semester;
  final int pupilId;
  final String markType;
  final String? markValue;
  final String? markNote;
  PostMOETPrimary({
    required this.classId,
    required this.markNote,
    required this.markType,
    required this.markValue,
    required this.pupilId,
    required this.semester,
    required this.subjectId,
  });
}

class UpdateTerm extends ClassScoreEvent {
  final Semester semester;
  UpdateTerm({required this.semester});
}

class GetMarkType extends ClassScoreEvent {
  final String subjectType;
  final String capDaoTao;
  final int classId;
  GetMarkType({
    required this.capDaoTao,
    required this.classId,
    required this.subjectType,
  });
}

class GetStudentInputScoreMoetHigh extends ClassScoreEvent {
  final int classId;
  final String label;
  GetStudentInputScoreMoetHigh({
    required this.classId,
    required this.label,
  });
}

class GetFormMoet extends ClassScoreEvent {
  final int classId;
  final int subjectId;
  final String learnYear;
  final String semester;
  GetFormMoet({
    required this.classId,
    required this.learnYear,
    required this.semester,
    required this.subjectId,
  });
}

class PostMoetHigh extends ClassScoreEvent {
  final int subjectId;
  final int classId;
  final String semester;
  final List<JsonDataMoet> data;
  PostMoetHigh(
      {required this.classId,
      required this.data,
      required this.semester,
      required this.subjectId});
}

class GetFormScoreESL extends ClassScoreEvent {
  final int classId;
  final int subjectId;
  final String scoreType;
  final int semester;
  final String learnYear;
  GetFormScoreESL({
    required this.classId,
    required this.learnYear,
    required this.scoreType,
    required this.semester,
    required this.subjectId,
  });
}

class GetPrimaryConduct extends ClassScoreEvent {
  final String userKey;
  final String txtHocKy;
  final String learnYaer;
  final String hkTihValue;
  GetPrimaryConduct({
    required this.hkTihValue,
    required this.learnYaer,
    required this.txtHocKy,
    required this.userKey,
  });
}

class GetFormConduct extends ClassScoreEvent {}

class PostPrimaryConduct extends ClassScoreEvent {
  final String userKey;
  final int classid;
  final String learnYear;
  final int hocKy;
  final int hocKyTih;
  final List<ConductScore> dataConduct;
  PostPrimaryConduct({
    required this.classid,
    required this.dataConduct,
    required this.hocKy,
    required this.hocKyTih,
    required this.learnYear,
    required this.userKey,
  });
}

class AddScoreConduct extends ClassScoreEvent {
  final List<ConductScore> data;
  AddScoreConduct({
    required this.data,
  });
}

class PostEslGpa extends ClassScoreEvent {
  final int classId;
  final int semester;
  final String learnYear;
  final List<JsonDataESL> dataESL;
  PostEslGpa({
    required this.classId,
    required this.dataESL,
    required this.learnYear,
    required this.semester,
  });
}
