import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'hourly_assessment_event.dart';
part 'hourly_assessment_state.dart';

class HourlyAssessmentBloc
    extends Bloc<HourlyAssessmentEvent, HourlyAssessmenState> {
  HourlyAssessmentBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(HourlyAssessmenState(
          moetEvaluation: MoetEvaluation.fakeData(),
        )) {
    on<GetMoetEvaluationForm>(_onGetMoetEvaluation);
    on<UpdateCriteria>(_onUpdateCriteria);
  }

  final CurrentUserBloc currentUserBloc;
  final AppFetchApiRepository appFetchApiRepository;

  void _onGetMoetEvaluation(
      GetMoetEvaluationForm event, Emitter<HourlyAssessmenState> emit) async {
    emit(state.copyWith(
      status: HourlyAssessmentStatus.loading,
      moetEvaluation: MoetEvaluation.fakeData(),
    ));

    final data = await appFetchApiRepository.getMoetEvaluation(
      userKey: currentUserBloc.state.user.user_key,
      lessonRegisterId: event.lessonRegisterId,
      lessonRegisterIdType: 'VI_VN',
    );

    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      moetEvaluation: data,
      status: HourlyAssessmentStatus.success,
    ));
  }

  void _onUpdateCriteria(
      UpdateCriteria event, Emitter<HourlyAssessmenState> emit) async {
    emit(state.copyWith(status: HourlyAssessmentStatus.updating, errorMsg: ''));
    
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
      emit(state.copyWith(status: HourlyAssessmentStatus.updateSuccess));
    } else {
      emit(state.copyWith(
        errorMsg: data['status_note'],
        status: HourlyAssessmentStatus.updateFailure,
      ));
    }
  }
}
