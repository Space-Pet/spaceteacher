part of 'survey_bloc.dart';

abstract class SurveyEvent extends Equatable {}

class GetSurvey extends SurveyEvent {
  GetSurvey();

  @override
  List<Object?> get props => [];
}
class PostSurvey extends SurveyEvent {
  final List<Map<String, dynamic>> listSurvey;
  PostSurvey({required this.listSurvey});
   @override
  List<Object?> get props => [listSurvey];
}

