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
            programList: const [],
            scoreProgram: ScoreProgram.empty(),
            moetTypeScore: ScoreModel.fakeData(),
            moetAverage: MoetAverage.empty(),
            eslScore: EslScore.empty(),
            primaryConduct: PrimaryConduct.empty(),
            txtLearnYear: ScoreState._calculateYearRange(),
          ),
        ) {
    on<ScoreFetchProgramList>(_onFetchProgramList);
    add(ScoreFetchProgramList());

    on<ScoreFetchData>(_onFethScoreData);
    on<ScoreFilterChange>(_onUpdateScoreFilter);

    on<ScoreFetchMoetType>(_onFetchMoetTypeScore);
    on<ScoreFetchMoetAverage>(_onFetchMoetAverage);
    on<ScoreFetchPrimaryConduct>(_onFetchPrimaryConduct);

    on<ScoreFetchEsl>(_onFetchEslScore);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchProgramList(
      ScoreFetchProgramList event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(programListStatus: ScoreProgramStatus.loading));

    final activeChild = currentUserBloc.state.activeChild;

    final prgramListData = await appFetchApiRepo.getProgramList(
      userKey: activeChild.user_key,
      // userKey: '02033200186',
      txtYear: state.txtLearnYear,
    );

    final firstProgram = prgramListData.data.first;
    emit(
      state.copyWith(
        programList: prgramListData.data,
        scoreProgram: firstProgram,
        txtLearnYear: prgramListData.txtLearnYear,
        isPrimaryStudent: activeChild.isPrimary(),
        programListStatus: ScoreProgramStatus.loaded,
      ),
    );

    add(ScoreFetchData());
  }

  _onFethScoreData(ScoreFetchData event, Emitter<ScoreState> emit) {
    if (state.scoreProgram.ctId == 'esl') {
      add(ScoreFetchEsl());
    } else {
      add(ScoreFetchMoetType());
    }
  }

  _onFetchMoetTypeScore(
      ScoreFetchMoetType event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loading));

    if (state.scoreProgram.ctName.contains('MOET')) {
      if (state.isPrimaryStudent) {
        add(ScoreFetchPrimaryConduct());
      } else {
        add(ScoreFetchMoetAverage());
      }
    }

    final scoreTypeMoetData = await appFetchApiRepo.getMoetTypeScore(
      userKey: currentUserBloc.state.activeChild.user_key,
      // userKey: '0563180077',
      // userKey: '02033200186',
      txtYear: state.txtLearnYear,
      txtHocKy: state.txtHocKy.getValue(),
      ctId: state.scoreProgram.ctId,
    );

    await Future.delayed(const Duration(seconds: 5));

    emit(
      state.copyWith(
        moetTypeScore: scoreTypeMoetData,
        status: ScoreStatus.loaded,
      ),
    );
  }

  _onFetchMoetAverage(
      ScoreFetchMoetAverage event, Emitter<ScoreState> emit) async {
    final moetAverage = await appFetchApiRepo.getMoetAverage(
      userKey: currentUserBloc.state.activeChild.user_key,
      // userKey: '0563180077',
      txtYear: state.txtLearnYear,
      txtHocKy: state.txtHocKy.getValue(),
    );

    emit(state.copyWith(moetAverage: moetAverage));
  }

  _onFetchPrimaryConduct(
      ScoreFetchPrimaryConduct event, Emitter<ScoreState> emit) async {
    final conductData = await appFetchApiRepo.getPrimaryConduct(
      userKey: currentUserBloc.state.activeChild.user_key,
      // userKey: '02033200186',
      txtHocKy: state.txtHocKy.getValue(),
      txtYear: state.txtLearnYear,
      hkTihValue: state.txtTihHocKy.getValue().toString(),
    );
    emit(
      state.copyWith(primaryConduct: conductData),
    );
  }

  _onFetchEslScore(ScoreFetchEsl event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loading));

    final scoreData = await appFetchApiRepo.getEslScore(
      userKey: currentUserBloc.state.activeChild.user_key,
      // userKey: '0253220010',
      txtHocKy: state.txtHocKy.getValue(),
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
    final newFilter = event.scoreFilter;
    switch (newFilter.filterType) {
      case FilterType.program:
        final selectedProgram = state.programList.firstWhere(
            (element) => element.ctName == newFilter.selectedScoreProgram);

        emit(state.copyWith(scoreProgram: selectedProgram));
        break;

      case FilterType.learnYear:
        emit(state.copyWith(txtLearnYear: newFilter.selectedYear));
        break;

      case FilterType.term:
        final newTerm = newFilter.selectedTerm;
        if (state.isPrimaryStudent) {
          final matchTemp = PrimaryTermType.values
              .firstWhere((element) => newTerm == element.text());

          emit(state.copyWith(
            txtTihHocKy: matchTemp,
            txtHocKy:
                matchTemp.getValue() < 3 ? TermType.term1 : TermType.term2,
          ));
        } else {
          final matchTemp = TermType.values
              .firstWhere((element) => newTerm == element.text());

          emit(state.copyWith(txtHocKy: matchTemp));
        }
        break;

      default:
        break;
    }

    add(ScoreFetchData());
  }
}
