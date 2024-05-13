part of 'survey_bloc.dart';

enum SurveyStatus { init, loadingSurvey, successSurvey }

class SurveyState extends Equatable {
  final SurveyStatus surveyStatus;
  final List<SurveyData> surveyData;
  final List<CheckBox>? checkBox;
  const SurveyState(
      {required this.surveyData, this.surveyStatus = SurveyStatus.init, this.checkBox});
  @override
  List<Object?> get props => [surveyData, surveyStatus, checkBox];

  SurveyState copyWith(
      {SurveyStatus? surveyStatus,
      List<SurveyData>? surveyData,
      List<CheckBox>? checkBox}) {
    return SurveyState(
        checkBox: checkBox ?? this.checkBox,
        surveyData: surveyData ?? this.surveyData,
        surveyStatus: surveyStatus ?? this.surveyStatus);
  }
}

class CheckBox {
  final int id;
  final int level;
  const CheckBox({required this.id, required this.level});
}
