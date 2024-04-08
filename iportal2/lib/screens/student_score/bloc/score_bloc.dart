import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:meta/meta.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
// import 'package:network_data_source/src/register_notebook_api/models/exercise_data.dart';
part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
    this.txtHocKy,
    this.txtLearnYear,
    this.scoreType,
  }) : super(
          ScoreState(
              userKey: currentUserBloc.state.user.user_key,
              txtHocKy: txtHocKy,
              txtLearnYear: txtLearnYear,
              scoreType: scoreType,
              scoreData: ScoreResData.empty()),
        ) {
    on<ScoreFetchData>(_onScoreData);
    on<ScoreTxtTermChange>(_onUpdateTerm);
    on<ScoreLearnYearChange>(_onUpdateYearLearn);
    on<ScoreFilterChange>(_onUpdateScoreFilter);
    add(ScoreFetchData());
  }

  // final RegisterNotebookRepository registerNoteBookRepo;
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final String? txtHocKy;
  final String? txtLearnYear;
  final String? scoreType;
  _onScoreData(ScoreFetchData event, Emitter<ScoreState> emit) async {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int previousYear = currentYear - 1;

    String yearRange = '$previousYear-$currentYear';
    final scoreData = await appFetchApiRepo.getScore(
      userKey: currentUserBloc.state.user.user_key,
      txtTerm: state.txtHocKy == null ? '1' : state.txtHocKy!,
      txtYear: state.txtLearnYear == null ? yearRange : state.txtLearnYear!,
    );
    emit(
      state.copyWith(
          yearList: scoreData.listYear,
          scoreData: ScoreResData(
              txtDiemMoet: scoreData.txtDiemMoet, listYear: scoreData.listYear),
          txtHocKy: txtHocKy,
          txtLearnYear: txtHocKy,
          userKey: currentUserBloc.state.user.user_key),
    );
  }

  void _onUpdateTerm(
    ScoreTxtTermChange event,
    Emitter<ScoreState> emit,
  ) {
    final newTerm = event.txtHocKy;

    final newState = state.copyWith(txtHocKy: newTerm);
    emit(newState);
  }

  void _onUpdateYearLearn(
    ScoreLearnYearChange event,
    Emitter<ScoreState> emit,
  ) {
    final newYear = event.txtLearnYear;
    final newState = state.copyWith(txtLearnYear: newYear);
    emit(newState);
  }

  void _onUpdateScoreFilter(
    ScoreFilterChange event,
    Emitter<ScoreState> emit,
  ) {
    final newScoreType = event.scoreFilter.selectedScoreType;
    final newYear = event.scoreFilter.selectedYear;
    final newTerm = event.scoreFilter.selectedTerm;
    print('1sad31314 ${event.scoreFilter}');
    final newState = state.copyWith(
      txtLearnYear: newYear,
      scoreType: newScoreType,
      txtHocKy: newTerm,
    );
    emit(newState);
  }
}
