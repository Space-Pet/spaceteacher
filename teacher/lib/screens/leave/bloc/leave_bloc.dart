import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(const LeaveState()) {
    on<GetLeaves>(_onGetLeaves);
    on<PostLeave>(_onPostLeave);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onGetLeaves(GetLeaves event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await appFetchApiRepo.getLeaves(
        // TODO: bind API teacher
        classId: currentUserBloc.state.user.teacher_id,
        pupilId: currentUserBloc.state.user.teacher_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand);
    emit(state.copyWith(leaveStatus: LeaveStatus.success, leaveData: data));
  }

  void _onPostLeave(PostLeave event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await appFetchApiRepo.postLeave(
        content: event.content,
        // TODO: bind API teacher
        pupilId: currentUserBloc.state.user.teacher_id,
        startDate: event.startDate,
        endDate: event.endDate,
        leaveType: event.leaveType,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand);
    if (data['code'] == 200) {
      emit(state.copyWith(leaveStatus: LeaveStatus.success));
    } else {
      emit(state.copyWith(
          leaveStatus: LeaveStatus.error, message: data['message']));
    }
  }
}
