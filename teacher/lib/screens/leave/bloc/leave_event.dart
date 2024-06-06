part of 'leave_bloc.dart';

abstract class LeaveEvent {}

class GetLeaves extends LeaveEvent {}

class LeaveSelectDate extends LeaveEvent {
  LeaveSelectDate({required this.datePicked});

  final DateTime datePicked;
}

class LeaveFilter extends LeaveEvent {
  LeaveFilter({required this.newStatus});

  final LeaveStatusValue newStatus;
}

class LeaveAprroveAll extends LeaveEvent {
  LeaveAprroveAll();
}

class LeaveApprove extends LeaveEvent {
  final int pupilId;
  final String startDate;
  final String endDate;

  LeaveApprove({
    required this.pupilId,
    required this.endDate,
    required this.startDate,
  });
}
