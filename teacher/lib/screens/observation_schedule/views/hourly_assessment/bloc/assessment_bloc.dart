import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmenState> {
  AssessmentBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(AssessmenState(
          assessment: Assessment.fakeData(),
        )) {
    on<GetAssessmentCriterias>(_onGetAssessmentCriteria);
    on<UpdateCriteria>(_onUpdateCriteria);
  }

  final CurrentUserBloc currentUserBloc;
  final AppFetchApiRepository appFetchApiRepository;

  void _onGetAssessmentCriteria(
    GetAssessmentCriterias event,
    Emitter<AssessmenState> emit,
  ) async {
    if (!event.isRefresh) {
      emit(state.copyWith(
        status: AssessmentStatus.loading,
        assessment: Assessment.fakeData(),
      ));
    }

    final data = await appFetchApiRepository.onGetAssessmentCriteria(
      userKey: currentUserBloc.state.user.user_key,
      lessonRegisterId: event.lessonRegisterId,
      lessonRegisterIdType: event.type,
    );

    emit(state.copyWith(assessment: data));

    if (!event.isRefresh) {
      emit(state.copyWith(status: AssessmentStatus.success));
    }
  }

  void _onUpdateCriteria(
      UpdateCriteria event, Emitter<AssessmenState> emit) async {

    final body = {
      "lesson_register_id": event.lessonRegisterId,
      "user_key": currentUserBloc.state.user.user_key,
      "NOTE_ID": event.noteId,
      "diem_dat": event.diemDat,
      "tieu_chi_diem": event.tieuChiDiem,
      "nhan_xet": event.nhanXet,
    };

    final data = await appFetchApiRepository.updateMoetEvaluation(body);

    if (data == null) {
      return;
    }

    if (data['status'] == 'Success') {
      // emit(state.copyWith(status: HourlyAssessmentStatus.updateSuccess));
    } else {
      emit(state.copyWith(
        errorMsg: data['status_note'],
        status: AssessmentStatus.updateFailure,
      ));
      add(GetAssessmentCriterias(
        lessonRegisterId: event.lessonRegisterId,
        isRefresh: true,
      ));
    }
  }
}
