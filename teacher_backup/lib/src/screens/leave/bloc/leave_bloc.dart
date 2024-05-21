import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/model/leave_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/leave_repository/leave_repository.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc({
    required this.leaveRepositoryl,
  }) : super(LeaveState(selectedDate: DateTime.now())) {
    on<GetLeaves>(_onGetLeaves);
    on<GetHistoryLeave>(_onGetHistoryLeave);
  }
  final LeaveRepository leaveRepositoryl;

  void _onGetHistoryLeave(
      GetHistoryLeave event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await leaveRepositoryl.getHistoryLeave(
        userInfo: event.userInfo, date: event.date);
    emit(state.copyWith(
      leaveStatus: LeaveStatus.success,
      leaveData: data,
      selectedDate: event.selectedDate,
    ));
  }

  void _onGetLeaves(GetLeaves event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(leaveStatus: LeaveStatus.init));
    final data = await leaveRepositoryl.getLeave(userInfo: event.userInfo);
    emit(state.copyWith(leaveStatus: LeaveStatus.success, leaveData: data));
  }
}
