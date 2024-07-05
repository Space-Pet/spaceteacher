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
    required this.userRepository,
  }) : super(
          ScoreState(
            markType: MarkTypeColumn.fakeData(),
            moetAverage: MoetAverage.empty(),
            learnYear: LearnYear.empty(),
            classLeader: ListClassLeader.empty(),
            programList: [ScoreProgram.empty()],
            scoreProgram: ScoreProgram.empty(),
            userData: TeacherDetail.empty(),
            phoneBookStudent: PhoneBookStudent.fakeData(),
            formInputScore: FormInputScore.empty(),
            localTeacher: LocalTeacher.empty(),
            moetScore: ScoreModel.empty(),
            eslScore: EslScore.empty(),
            primaryConduct: PrimaryConduct.empty(),
            txtLearnYear: ScoreState._calculateYearRange(),
          ),
        ) {
    on<SelectYear>(_onSelectedYear);
    on<ClassListFetched>(_onClassListFetch);
    on<ScoreFilterChange>(_onUpdateScoreFilter);
    on<ScoreFilterSemester>(_onScoreFilterSemester);
    on<GetMarkType>(_onGetMarkType);
    on<GetFormInputScore>(_onGetFormInputScore);
    on<GetListStudent>(_onGetListStudent);
    on<GetTeacherDetail>(_getTeacherDetail);
    on<GetEslScore>(_onGetEslScore);
    on<ScoreFetchProgramList>(_onFetchProgramList);
    on<GetClassLeader>(_onGetClassLeader);
    on<ScoreFetchMoetType>(_onFetchMoetTypeScore);
    on<EditScore>(_editScore);
    on<ScoreFetchPrimaryConduct>(_onScoreFetchPrimaryConduct);
    on<GetLearnYear>(_onGetLeanrYear);
    on<PostCommentMoet>(_onPostCommentMoet);
    on<ScoreFetchMoetAverage>(_onScoreFetchMoetAverage);

    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(localTeacher: currentUserBloc.state.user));
  }

  // final RegisterNotebookRepository registerNoteBookRepo;
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  _onSelectedYear(
    SelectYear event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(txtLearnYear: event.txtLearnYear));
  }

  _onGetMarkType(
    GetMarkType event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingMarkType));
    final data = await appFetchApiRepo.getMarkType(
      subjectType: event.subjectType,
      classId: event.classId,
      capDaoTao: event.capDaoTao,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(status: ScoreStatus.successMarkType, markType: data));
  }

  _onScoreFetchMoetAverage(
    ScoreFetchMoetAverage event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingGetMoetAverage));
    final data = await appFetchApiRepo.getMoetAverage(
      userKey: event.userkey,
      txtHocKy: event.txtHocKy.toString(),
      txtYear: event.learnYear,
    );
    emit(state.copyWith(
        status: ScoreStatus.successGetMoetAverage, moetAverage: data));
  }

  _onPostCommentMoet(
    PostCommentMoet event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingPostComment));
    final data = await appFetchApiRepo.postCommentMoet(
      userKey: currentUserBloc.state.user.user_key,
      pupilId: event.pupilId,
      subjectId: event.subjectId,
      coomentContent: event.commnetContent,
      learnYear: event.learnYear,
      hkTihValue: event.hkTihValue,
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
    );
    emit(state.copyWith(
        status: data['status'] == 'Success'
            ? ScoreStatus.successPostComment
            : ScoreStatus.fail,
        message: data['status'] == 'Success' ? '' : data['status_note']));
  }

  _onGetLeanrYear(
    GetLearnYear event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingLearnYear));
    final data = await appFetchApiRepo
        .getLearnYearList(currentUserBloc.state.user.school_id);
    emit(state.copyWith(learnYear: data, status: ScoreStatus.successLearnYear));
  }

  _onScoreFetchPrimaryConduct(
    ScoreFetchPrimaryConduct event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingPrimaryConduct));
    final data = await appFetchApiRepo.getPrimaryConduct(
      userKey: event.userKey,
      txtHocKy: event.txtHocKy,
      txtYear: event.txtYear,
      hkTihValue: event.hkTihValue,
    );
    emit(
      state.copyWith(
        status: ScoreStatus.successPrimaryConduct,
        primaryConduct: data,
      ),
    );
  }

  _editScore(EditScore event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(edit: event.edit));
  }

  _onFetchMoetTypeScore(
      ScoreFetchMoetType event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(
        status: ScoreStatus.loadingGetMoetOther,
        moetScore: ScoreModel.empty()));

    // if (state.scoreProgram.ctName.contains('MOET')) {
    //   if (state.isPrimaryStudent) {
    //     add(ScoreFetchPrimaryConduct());
    //   } else {
    //     add(ScoreFetchMoetAverage());
    //   }
    // }

    final scoreTypeMoetData = await appFetchApiRepo.getMoetTypeScore(
      isMOET: event.isMOETCheck,
      userKey: event.userKey,
      txtYear: event.learnYear,
      txtHocKy: event.txtHocKy,
      ctId: event.ctId,
    );

    //await Future.delayed(const Duration(seconds: 5));

    emit(
      state.copyWith(
        moetScore: scoreTypeMoetData,
        status: ScoreStatus.successGetMoetOther,
      ),
    );
  }

  _onGetClassLeader(
    GetClassLeader event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingClassLeader));
    final data = await appFetchApiRepo.getClassLeader(
      learnYear: event.learnYear,
      userKey: currentUserBloc.state.user.user_key,
    );
    emit(state.copyWith(
        status: ScoreStatus.successClassLeader, classLeader: data));
  }

  _onFetchProgramList(
      ScoreFetchProgramList event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loading));
    final prgramListData = await appFetchApiRepo.getProgramList(
      userKey: event.userKey,
      txtYear: state.txtLearnYear,
    );

    final firstProgram = prgramListData.data.first;
    emit(
      state.copyWith(
        isMOET: firstProgram.ctName,
        programList: prgramListData.data,
        scoreProgram: firstProgram,
        txtLearnYear: prgramListData.txtLearnYear,
        status: ScoreStatus.success,
      ),
    );
  }

  _onGetEslScore(
    GetEslScore event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingGetEsl));
    final data = await appFetchApiRepo.getEslScore(
      userKey: event.userKey,
      txtTerm: event.txtTerm,
      txtYear: event.txtYear,
    );
    emit(state.copyWith(status: ScoreStatus.successGetEsl, eslScore: data));
  }

  _onGetListStudent(
    GetListStudent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingGetListStudent));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: event.classId,
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
    );
    emit(state.copyWith(
        status: ScoreStatus.successGetListStudent, phoneBookStudent: data));
  }

  _onScoreFilterSemester(
    ScoreFilterSemester event,
    Emitter<ScoreState> emit,
  ) async {
    emit(state.copyWith(status: ScoreStatus.loadingSemesterLeaderTeacher));
    final data = await appFetchApiRepo.getSemester(
      subjectType: event.subjectType,
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

  void _onUpdateScoreFilter(
    ScoreFilterChange event,
    Emitter<ScoreState> emit,
  ) {
    final newScoreType = event.scoreFilter.selectedScoreType;
    final newYear = event.scoreFilter.selectedYear;
    final newTerm = event.scoreFilter.selectedTerm;
    emit(state.copyWith(
      ctId: event.ctId,
      status: ScoreStatus.loadedUpdateProgram,
      scoreType: newScoreType,
      termType: event.scoreFilter.valueTerm,
      type: event.type,
      isMOET: event.isMOET,
    ));
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

  _getTeacherDetail(GetTeacherDetail event, Emitter<ScoreState> emit) async {
    emit(state.copyWith(status: ScoreStatus.loadingGetTeacherDetail));
    final data = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());
    emit(state.copyWith(
        status: ScoreStatus.successGetTeacherDetail, userData: data));
  }
}
