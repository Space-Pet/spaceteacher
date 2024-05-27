import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(LeaveState(user: userRepository.notSignedIn())) {
    on<GetLeaves>(_onGetLeaves);
    on<CurrentUserUpdated>(_onUpdateUser);
    on<PostLeave>(_onPostLeave);

  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(
      user: event.user,
    ));
  }

  void _onGetLeaves(GetLeaves event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await appFetchApiRepo.getLeaves(
        classId: currentUserBloc.state.user.children[0].class_id,
        pupilId: currentUserBloc.state.user.children[0].pupil_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand);
    emit(state.copyWith(leaveStatus: LeaveStatus.success, leaveData: data));
  }

  

  void _onPostLeave(PostLeave event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await appFetchApiRepo.postLeave(
        content: event.content,
        pupilId: currentUserBloc.state.user.pupil_id,
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
