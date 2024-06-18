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
