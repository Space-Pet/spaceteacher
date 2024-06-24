part of 'survey_bloc.dart';

enum SurveyStatus { init, loadingSurvey, successSurvey }

class SurveyState extends Equatable {
  final SurveyStatus surveyStatus;
  final List<Survey> surveyList;
  final SurveyDetail surveyDetail;
  final List<CheckBox>? checkBox;

  const SurveyState({
    required this.surveyDetail,
    required this.surveyList,
    this.surveyStatus = SurveyStatus.init,
    this.checkBox,
  });

  @override
  List<Object?> get props => [
        surveyList,
        surveyDetail,
        surveyStatus,
        checkBox,
      ];

  SurveyState copyWith({
    List<Survey>? surveyList,
    SurveyStatus? surveyStatus,
    SurveyDetail? surveyDetail,
    List<CheckBox>? checkBox,
  }) {
    return SurveyState(
      surveyList: surveyList ?? this.surveyList,
      checkBox: checkBox ?? this.checkBox,
      surveyDetail: surveyDetail ?? this.surveyDetail,
      surveyStatus: surveyStatus ?? this.surveyStatus,
    );
  }
}

class CheckBox {
  final int id;
  final int level;
  const CheckBox({required this.id, required this.level});
}
