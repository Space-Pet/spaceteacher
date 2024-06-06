part of 'leave_bloc.dart';

abstract class LeaveEvent {}

class GetLeaves extends LeaveEvent {
  final int page;
  GetLeaves({required this.page});
  List<Object> get props => [page];
}


class PostLeave extends LeaveEvent {
  final String? content;
  final String startDate;
  final String endDate;
  final int leaveType;
  PostLeave(
      {required this.endDate,
      this.content,
      required this.leaveType,
      required this.startDate});
}
