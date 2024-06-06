part of 'survey_bloc.dart';

abstract class SurveyEvent extends Equatable {}

class GetSurveyList extends SurveyEvent {
  GetSurveyList();

  @override
  List<Object?> get props => [];
}

class GetSurvey extends SurveyEvent {
  GetSurvey({required this.khaoSatId});

  final int khaoSatId;

  @override
  List<Object?> get props => [khaoSatId];
}

class PostSurvey extends SurveyEvent {
  final List<Map<String, dynamic>> listSurvey;
  final int khaoSatId;
  PostSurvey({required this.listSurvey, required this.khaoSatId});
  @override
  List<Object?> get props => [listSurvey, khaoSatId];
}
