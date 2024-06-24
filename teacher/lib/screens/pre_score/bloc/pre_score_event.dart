part of 'pre_score_bloc.dart';

sealed class PreScoreEvent {}

class GetListStudents extends PreScoreEvent {}

class GetTeacherDetail extends PreScoreEvent {}

class GetArmorial extends PreScoreEvent {}

class GetComment extends PreScoreEvent {
  final String userKey;
  final String txtDate;
  final DateTime startDate;
  final DateTime endDate;
  GetComment({
    required this.endDate,
    required this.startDate,
    required this.txtDate,
    required this.userKey,
  });
}

class PostComment extends PreScoreEvent {
  final String userKey;
  final int pupilId;
  final String weekDay;
  final String commentMnContent;
  final String huyHieuId;
  final String commentMnTitle;
  PostComment({
    required this.commentMnContent,
    required this.commentMnTitle,
    required this.huyHieuId,
    required this.pupilId,
    required this.userKey,
    required this.weekDay,
  });
}

class GetListAllForm extends PreScoreEvent {}

class GetListStudentReport extends PreScoreEvent {
  final int id;
  final int classId;
  GetListStudentReport({
    required this.classId,
    required this.id,
  });
}

class GetFormDetail extends PreScoreEvent {
  final int id;
  final int pupilId;
  GetFormDetail({
    required this.id,
    required this.pupilId,
  });
}

class PostUpdateReport extends PreScoreEvent {
  final int pupilId;
  final String evaluationFormId;
  final String commentText;
  final String teacherEvaluation;
  final int classId;
  final List<List<UpdateReport>> updateReport;

  PostUpdateReport({
    required this.classId,
    required this.commentText,
    required this.evaluationFormId,
    required this.pupilId,
    required this.teacherEvaluation,
    required this.updateReport,
  });
}
