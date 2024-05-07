
import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
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
      : super(const PreScoreState(comment: [])) {
    on<GetComment>(_onGetComment);
    on<GetListReportStudent>(_onGetListReportStudent);
    on<GetReportStudent>(_onGetReportStudent);
    on<ScoreTxtTermChange>(_onUpdateTerm);
  }
  void _onUpdateTerm(
    ScoreTxtTermChange event,
    Emitter<PreScoreState> emit,
  ) {
    final newTerm = event.txtHocKy;

    final newState = state.copyWith(txtHocKy: newTerm);
    emit(newState);
  }

  void _onGetComment(GetComment event, Emitter<PreScoreState> emit) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loading));
    final data = await appFetchApiRepo.getComment(
        userKey: currentUserBloc.state.user.user_key, txtDate: event.txtDate);
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.success,
        comment: data,
        endDate: event.endDate,
        startDate: event.startDate));
  }

  void _onGetListReportStudent(
      GetListReportStudent event, Emitter<PreScoreState> emit) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingListReport));
    final data = await appFetchApiRepo.getListReportStudent(
        pupilId: currentUserBloc.state.user.pupil_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
        semester: event.semester,
        learnYear: event.learnYear);
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.successListReport,
        listReportStudent: data));
  }

  void _onGetReportStudent(
      GetReportStudent event, Emitter<PreScoreState> emit) async {
    emit(state.copyWith(preScoreStatus: PreScoreStatus.loadingReportStudent));
    final data = await appFetchApiRepo.getReportStudent(
      id: event.id,
      pupilId: currentUserBloc.state.user.pupil_id,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
        preScoreStatus: PreScoreStatus.successReportStudent,
        reportStudent: data));
  }
}
