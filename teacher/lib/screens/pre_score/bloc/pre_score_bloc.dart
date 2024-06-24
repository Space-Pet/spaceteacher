import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'pre_score_event.dart';
part 'pre_score_state.dart';

class PreScoreBloc extends Bloc<PreScoreEvent, PreScoreState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  PreScoreBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(PreScoreState(
          formDetail: FormDetail.empty(),
          listStudentFormReport: ListStudentFormReport.fakeData(),
          listAllForm: ListAllForm.fakeDate(),
          status: '',
          comment: Comment.fakeData(),
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          userData: TeacherDetail.empty(),
          armorial: Armorial.fakeData(),
        )) {
    on<GetListStudents>(_onGetListStudent);
    on<GetTeacherDetail>(_onGetTeacherDetail);
    on<GetArmorial>(_onGetArmorial);
    on<GetComment>(_onGetComment);
    on<PostComment>(_onPostComment);
    on<GetListAllForm>(_onGetListAllForm);
    on<GetListStudentReport>(_onGetListStudentReport);
    on<GetFormDetail>(_onGetFormDetail);
    on<PostUpdateReport>(_onPostUpdateReport);
  }
  _onPostUpdateReport(
    PostUpdateReport event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(
        state.copyWith(preScoreStatus: PreScoreStatus.loadingPostUpdateReport));
    final data = await appFetchApiRepo.postUpdateReportTeacher(
      pupilId: event.pupilId,
      evaluationFormId: event.evaluationFormId,
      commentText: event.commentText,
      teacherEvaluation: event.teacherEvaluation,
      classId: event.classId,
      updateReport: event.updateReport,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(
      state.copyWith(
        preScoreStatus: data['code'] == 200
            ? PreScoreStatus.successPostUpdateReport
            : PreScoreStatus.failPost,
      ),
    );
  }

  _onGetFormDetail(
    GetFormDetail event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetFormDetail));
    final data = await appFetchApiRepo.getFormDetail(
      id: event.id,
      pupilId: event.pupilId,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetFormDetail,
      formDetail: data,
    ));
  }

  _onGetListStudentReport(
    GetListStudentReport event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetListStudent));
    final data = await appFetchApiRepo.getListStudentFormReport(
      id: event.id,
      classId: event.classId,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetListStudentReport,
      listStudentFormReport: data,
    ));
  }

  _onGetListAllForm(
    GetListAllForm event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetForm));
    final data = await appFetchApiRepo.getListAllForm(
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.successGetForm, listAllForm: data));
  }

  _onPostComment(
    PostComment event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingPostComment));
    final data = await appFetchApiRepo.postScoreComment(
      userKey: event.userKey,
      pupilId: event.pupilId,
      weekDay: event.weekDay,
      commentMnContent: event.commentMnContent,
      huyHieuId: event.huyHieuId,
      commentMnTitle: event.commentMnTitle,
    );
    emit(state.copyWith(
      preScoreStatus: data['status'] == 'Success'
          ? PreScoreStatus.successPostComment
          : PreScoreStatus.failPost,
      status: data['status_note'],
    ));
  }

  _onGetComment(
    GetComment event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetComment));
    final data = await appFetchApiRepo.getComment(
      userKey: event.userKey,
      txtDate: event.txtDate,
    );
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.successGetComment,
        comment: data,
        startDate: event.startDate,
        endDate: event.endDate));
  }

  _onGetArmorial(
    GetArmorial event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetArmorial));
    final data = await appFetchApiRepo.getArmorial();
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetArmorial,
      armorial: data,
    ));
  }

  _onGetTeacherDetail(
    GetTeacherDetail event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(
        state.copyWith(preScoreStatus: PreScoreStatus.loadingGetTeacherDetail));
    final teacherDetail = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetTeacherDetail,
      userData: teacherDetail,
    ));
  }

  _onGetListStudent(
    GetListStudents event,
    Emitter<PreScoreState> emit,
  ) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingGetListStudent));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: state.userData.lopChuNhiem.id,
    );
    emit(state.copyWith(
      preScoreStatus: PreScoreStatus.successGetListStudent,
      listStudent: data,
    ));
  }
}
