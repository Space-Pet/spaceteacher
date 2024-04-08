part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object?> get props => [];
}

class GetAttendanceDay extends AttendanceEvent {
  const GetAttendanceDay({required this.date});
  final String date;
}

class GetAttendanceWeek extends AttendanceEvent {
  const GetAttendanceWeek({required this.endDate, required this.startDate});
  final String startDate;
  final String endDate;
  @override
  List<Object> get props => [];
}
class GetAttendanceMonth extends AttendanceEvent {
  const GetAttendanceMonth({required this.endDate, required this.startDate});
  final String startDate;
  final String endDate;
  @override
  List<Object> get props => [];
}

