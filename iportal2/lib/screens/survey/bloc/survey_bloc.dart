import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(SurveyState(
          surveyDetail: SurveyDetail.empty(),
          surveyList: Survey.fakeData(),
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

    final data = await appFetchApiRepository.getSurveyList(
      capDaoTaoId: currentUserBloc.state.activeChild.cap_dao_tao.id,
    );

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
