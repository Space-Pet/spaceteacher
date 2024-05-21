part of 'leave_bloc.dart';

abstract class LeaveEvent {}

class GetLeaves extends LeaveEvent {
  final UserInfo userInfo;
  GetLeaves({required this.userInfo});
  List<Object> get props => [userInfo];
}

class GetHistoryLeave extends LeaveEvent {
  final UserInfo userInfo;
  final String date;
  final DateTime selectedDate;
  GetHistoryLeave({required this.date, required this.userInfo, required this.selectedDate});
  List<Object> get props => [userInfo, date, selectedDate];
}
