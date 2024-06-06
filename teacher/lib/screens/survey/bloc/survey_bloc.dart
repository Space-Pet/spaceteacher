import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(SurveyState(
          surveyDetail: SurveyDetail.empty(),
          surveyList: const [],
        )) {
    on<GetSurveyList>(_onGetSurveyList);
    add(GetSurveyList());

    on<GetSurvey>(_onGetSurvey);
    on<PostSurvey>(_onPostSurvey);
  }

  final CurrentUserBloc currentUserBloc;
  final AppFetchApiRepository appFetchApiRepository;

  void _onGetSurveyList(GetSurveyList event, Emitter<SurveyState> emit) async {
    emit(state.copyWith(surveyStatus: SurveyStatus.loadingSurvey));

    final data = await appFetchApiRepository.getSurveyList();

    emit(state.copyWith(
      surveyList: data,
      surveyStatus: SurveyStatus.successSurvey,
    ));
  }

  void _onGetSurvey(GetSurvey event, Emitter<SurveyState> emit) async {
    emit(state.copyWith(surveyStatus: SurveyStatus.loadingSurvey));
    final data = await appFetchApiRepository.getSurveyDetail(event.khaoSatId);
    emit(state.copyWith(
      surveyDetail: data,
      surveyStatus: SurveyStatus.successSurvey,
    ));
  }

  void _onPostSurvey(PostSurvey event, Emitter<SurveyState> emit) async {
    print('PostSurvey ${event.listSurvey}');
    await appFetchApiRepository.postSurvey(
      listSurvey: event.listSurvey,
      khaoSatId: event.khaoSatId,
    );
  }
}
