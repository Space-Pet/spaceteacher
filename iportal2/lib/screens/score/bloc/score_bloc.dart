import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/score/score_screen.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(
          ScoreState(
            moetScore: ScoreModel.empty(),
            eslScore: EslScore.empty(),
            primaryConduct: PrimaryConduct.empty(),
            txtLearnYear: ScoreState._calculateYearRange(),
          ),
        ) {
    on<ScoreFetchMoet>(_onFetchMoetScore);
    on<ScoreFilterChange>(_onUpdateScoreFilter);
    on<ScoreFetchEsl>(_onFetchEslScore);
    on<ScoreFetchPrimaryConduct>(_onFetchPrimaryConduct);

    add(ScoreFetchMoet());
  }

  // final RegisterNotebookRepository registerNoteBookRepo;
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchMoetScore(ScoreFetchMoet event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loading));

    final scoreData = await appFetchApiRepo.getMoetScore(
      // userKey: currentUserBloc.state.user.user_key,
      userKey: '02033200186',
      txtHocKy: state.txtHocKy.getValue(),
      txtYear: state.txtLearnYear,
    );

    emit(
      state.copyWith(
        yearList: scoreData.listYear,
        moetScore: ScoreModel(
          txtDiemMoet: scoreData.txtDiemMoet,
          listYear: scoreData.listYear,
          txtCurrentYear: scoreData.txtCurrentYear,
          txtCurrentHocKy: scoreData.txtCurrentHocKy,
          txtKhoiLevel: scoreData.txtKhoiLevel,
        ),
        status: ScoreStatus.loaded,
      ),
    );

    if (int.tryParse(scoreData.txtKhoiLevel)! < 6) {
      add(ScoreFetchPrimaryConduct());
    }
  }

  _onFetchPrimaryConduct(
      ScoreFetchPrimaryConduct event, Emitter<ScoreState> emit) async {
    if (state.scoreType == ScoreType.moet.text()) {
      emit(state.copyWith(conducStatus: ScoreStatus.loading));

      final conductData = await appFetchApiRepo.getPrimaryConduct(
        // userKey: currentUserBloc.state.user.user_key,
        userKey: '02033200186',
        txtHocKy: state.txtHocKy.getValue(),
        txtYear: state.txtLearnYear,
        hkTihValue: state.txtTihHocKy.getValue().toString(),
      );
      emit(
        state.copyWith(
          primaryConduct: conductData,
          conducStatus: ScoreStatus.loaded,
        ),
      );
    }
  }

  _onFetchEslScore(ScoreFetchEsl event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loading));

    final scoreData = await appFetchApiRepo.getEslScore(
      userKey: currentUserBloc.state.user.user_key,
      // userKey: '0253220010',
      txtTerm: state.txtHocKy.getValue(),
      txtYear: state.txtLearnYear,
    );

    emit(
      state.copyWith(
        eslScore: scoreData,
        txtLearnYear: scoreData.learnYear,
        status: ScoreStatus.loaded,
      ),
    );
  }

  void _onUpdateScoreFilter(
    ScoreFilterChange event,
    Emitter<ScoreState> emit,
  ) {
    final newScoreType = event.scoreFilter.selectedScoreType;
    final newYear = event.scoreFilter.selectedYear;
    final newTerm = event.scoreFilter.selectedTerm;

    final newState = state.copyWith(
      txtLearnYear: newYear,
      scoreType: newScoreType,
    );

    final ScoreState newFilter;
    if (event.isPrimary) {
      final matchTemp = PrimaryTermType.values
          .firstWhere((element) => newTerm == element.text());

      newFilter = newState.copyWith(
        txtTihHocKy: matchTemp,
        txtHocKy: matchTemp.getValue() < 3 ? TermType.term1 : TermType.term2,
      );
    } else {
      final matchTemp =
          TermType.values.firstWhere((element) => newTerm == element.text());

      newFilter = newState.copyWith(
        txtHocKy: matchTemp,
      );
    }
    emit(newFilter);

    if (newScoreType == ScoreType.moet.text()) {
      add(ScoreFetchMoet());
    } else {
      add(ScoreFetchEsl());
    }
  }
}
