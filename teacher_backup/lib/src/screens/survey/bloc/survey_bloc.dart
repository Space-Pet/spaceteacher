import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/data/models/models.dart';
import 'package:teacher/repository/survey_repositories/survey_repositories.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository surveyRepository;
  SurveyBloc({required this.surveyRepository})
      : super(const SurveyState(surveyData: [])) {
    on<GetSurvey>(_onGetSurvey);
    // on<PostSurvey>(_onPostSurvey);
  }

  // void _onPostSurvey(PostSurvey event, Emitter<SurveyState> emit) async {
  //   await surveyRepository.postSurvey(listSurvey: event.listSurvey);
  // }

  void _onGetSurvey(GetSurvey event, Emitter<SurveyState> emit) async {
    emit(state.copyWith(surveyStatus: SurveyStatus.loadingSurvey));

    
    final data = await surveyRepository.getSurvey();
    emit(state.copyWith(
        surveyData: data, surveyStatus: SurveyStatus.successSurvey));
  }
}
