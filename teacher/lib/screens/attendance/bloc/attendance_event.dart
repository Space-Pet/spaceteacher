part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object?> get props => [];
}

class GetListClass extends AttendanceEvent {}

class GetAttendanceWeek extends AttendanceEvent {
  final int classId;
  final String startDate;
  final String endDate;
  const GetAttendanceWeek({
    required this.classId,
    required this.endDate,
    required this.startDate,
  });
  @override
  List<Object> get props => [
        classId,
        startDate,
        endDate,
      ];
}

class GetAttendanceMonth extends AttendanceEvent {
  final int classId;
  final String startDate;
  final String endDate;
  const GetAttendanceMonth({
    required this.classId,
    required this.endDate,
    required this.startDate,
  });
  @override
  List<Object> get props => [
        classId,
        startDate,
        endDate,
      ];
}

class GetAttendanceDay extends AttendanceEvent {
  final int classId;
  final String startDate;
  final String endDate;
  const GetAttendanceDay({
    required this.classId,
    required this.endDate,
    required this.startDate,
  });
  @override
  List<Object> get props => [
        classId,
        startDate,
        endDate,
      ];
}

class GetAttendanceClassTeacher extends AttendanceEvent {
  final String date;
  const GetAttendanceClassTeacher({
    required this.date,
  });
  @override
  List<Object> get props => [
        date,
      ];
}

class GetAttendanceClassLeader extends AttendanceEvent {
  final String date;
  const GetAttendanceClassLeader({
    required this.date,
  });
  @override
  List<Object> get props => [
        date,
      ];
}

// ignore: must_be_immutable
class ShowScreen extends AttendanceEvent {
  late int showScreen;
  final String? startDateWeek;
  final String? endDateWeek;
  final String? startDateMonth;
  final String? endDateMonth;
  final String? dateDay;
  ShowScreen({
    required this.showScreen,
    this.dateDay,
    this.endDateWeek,
    this.startDateWeek,
    this.startDateMonth,
    this.endDateMonth,
  });
  @override
  List<Object?> get props => [
        dateDay,
        showScreen,
        endDateWeek,
        startDateWeek,
        startDateMonth,
        endDateMonth,
      ];
}
