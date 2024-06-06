import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(LeaveState(
          leaveData: const [],
          leaveApproved: const [],
          datePicked: DateTime.now(),
        )) {
    on<GetLeaves>(_onGetLeaves);
    add(GetLeaves());

    on<LeaveApprove>(_onApproveLeave);
    on<LeaveSelectDate>(_onSelectDate);
    on<LeaveFilter>(_onFilter);
    on<LeaveAprroveAll>(_onApproveAll);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onGetLeaves(GetLeaves event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveTeacherStatus.loading));
    final isApprovedData = state.status == LeaveStatusValue.approved;

    final data = await appFetchApiRepo.getLeavesTeacher(
        status: state.status.value,
        startDate: isApprovedData ? state.datePicked : DateTime.now(),
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand);

    if (isApprovedData) {
      emit(state.copyWith(leaveApproved: data));
    } else {
      emit(state.copyWith(leaveData: data));
    }

    emit(state.copyWith(leaveStatus: LeaveTeacherStatus.success));
  }

  void _onApproveLeave(LeaveApprove event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveTeacherStatus.init));
    final data = await appFetchApiRepo.approveLeave(
      pupilId: event.pupilId,
      startDate: event.startDate,
      endDate: event.endDate,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );

    if (data['code'] == 200) {
      emit(state.copyWith(leaveStatus: LeaveTeacherStatus.approveSuccess));
    } else {
      emit(state.copyWith(
        leaveStatus: LeaveTeacherStatus.error,
        message: data['message'],
      ));
    }
  }

  _onSelectDate(LeaveSelectDate event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(datePicked: event.datePicked));
    add(GetLeaves());
  }

  _onFilter(LeaveFilter event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: event.newStatus));
    add(GetLeaves());
  }

  _onApproveAll(LeaveAprroveAll event, Emitter<LeaveState> emit) async {
    final listIdLeaves = state.leaveData.map((e) => e.id).toList();
    print(listIdLeaves);

    final data = await appFetchApiRepo.approveAllLeaves(
        ids: listIdLeaves,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand);

    if (data['code'] == 200) {
      emit(state.copyWith(leaveStatus: LeaveTeacherStatus.approveAllSuccess));
      add(GetLeaves());
    } else {
      emit(state.copyWith(
        leaveStatus: LeaveTeacherStatus.error,
        message: data['message'],
      ));
    }
  }
}
