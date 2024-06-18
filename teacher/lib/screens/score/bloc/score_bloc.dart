import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/data/data.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';
import 'package:repository/repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(
          ScoreState(
            formInputScore: FormInputScore.empty(),
            localTeacher: LocalTeacher.empty(),
            moetScore: ScoreModel.empty(),
            eslScore: EslScore.empty(),
            primaryConduct: PrimaryConduct.empty(),
            txtLearnYear: ScoreState._calculateYearRange(),
          ),
        ) {
    on<ClassListFetched>(_onClassListFetch);
    on<ScoreFilterChange>(_onUpdateScoreFilter);
    on<ScoreFilterSemester>(_onScoreFilterSemester);
    on<ScoreSemesterListClass>(_onScoreSemesterListClass);
    on<GetFormInputScore>(_onGetFormInputScore);

    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(localTeacher: currentUserBloc.state.user));
  }

  // final RegisterNotebookRepository registerNoteBookRepo;
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onScoreFilterSemester(
    ScoreFilterSemester event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingSemesterLeaderTeacher));
    final data = await appFetchApiRepo.getSemester(
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
      capDaoTao: currentUserBloc.state.user.cap_dao_tao.id,
    );
    emit(state.copyWith(
        semester: data, status: ScoreStatus.successSemesterLeaderTeacher));
  }

  _onGetFormInputScore(
    GetFormInputScore event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingFormScore));
    final data = await appFetchApiRepo.getFormInputScore(
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
      classId: event.classId,
      subjectId: event.subjectId,
      learnYear: event.learnYear,
      semester: event.semester,
    );
    emit(state.copyWith(
      status: ScoreStatus.successFormScore,
      formInputScore: data,
    ));
  }

  _onScoreSemesterListClass(
    ScoreSemesterListClass event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingSemesterTeacher));
    final data = await appFetchApiRepo.getSemester(
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
      capDaoTao: event.capDaoTao,
    );
    emit(state.copyWith(
        status: ScoreStatus.successSemesterTeacher, semesterTabTeaching: data));
  }

  void _onUpdateScoreFilter(
    ScoreFilterChange event,
    Emitter<ScoreState> emit,
  ) {
    final newScoreType = event.scoreFilter.selectedScoreType;
    final newYear = event.scoreFilter.selectedYear;
    final newTerm = event.scoreFilter.selectedTerm;
    emit(state.copyWith(
        scoreType: newScoreType, termType: event.scoreFilter.valueTerm));
  }

  Future<void> _onClassListFetch(
      ClassListFetched event, Emitter<ScoreState> emit) async {
    emit(
      state.copyWith(status: ScoreStatus.loadingListClass),
    );
    final data = await appFetchApiRepo.getListClassScore(
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
      learnYear: '2023-2024',
    );
    emit(state.copyWith(
        status: ScoreStatus.successListClass, listClassScore: data));
  }
}
