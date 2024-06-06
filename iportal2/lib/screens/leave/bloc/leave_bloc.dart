import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
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
    emit(state.copyWith(leaveStatus: LeaveStatusEnum.init));
    final data = await appFetchApiRepo.getLeaves(
        classId: currentUserBloc.state.user.children[0].class_id,
        pupilId: currentUserBloc.state.user.children[0].pupil_id,
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand);
    emit(state.copyWith(leaveStatus: LeaveStatusEnum.success, leaveData: data));
  }

  void _onPostLeave(PostLeave event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatusEnum.init));
    final data = await appFetchApiRepo.postLeave(
        content: event.content,
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        startDate: event.startDate,
        endDate: event.endDate,
        leaveType: event.leaveType,
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand);
    if (data['code'] == 200) {
      emit(state.copyWith(leaveStatus: LeaveStatusEnum.success));
    } else {
      emit(state.copyWith(
          leaveStatus: LeaveStatusEnum.error, message: data['message']));
    }
  }
}
