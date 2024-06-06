part of 'attendance_bloc.dart';

enum AttendanceStatus {
  init,
  loadingClass,
  successClass,
  failClass,
  loadingAttendanceWeek,
  loadingAttendanceMonth,
  loadingAttendanceDay,
  loadingAttendanceClassTeacher,
  loadingAttendanceClassLeader,
  successAttendanceWeek,
  successAttendanceMonth,
  successAttendanceDay,
  successAttendanceClassTeacher,
  successAttendanceClassLeader,
  failWeek,
  failMotnth,
  failDay,
  fail,
}

// ignore: must_be_immutable
class AttendanceState extends Equatable {
  final List<AttendanceTeacher> attendanceClassTeacher;
  final List<AttendanceTeacher> attendanceClassLeader;
  final AttendanceStatus attendanceStatus;
  final List<ClassTeacher> classTeacher;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final AttendanceWeek? attendanceDay;
  final String? startDate;
  final String? endDate;
  late int showScreen;
  AttendanceState({
    this.attendanceStatus = AttendanceStatus.init,
    this.classTeacher = const [],
    this.attendanceClassTeacher = const [],
    this.attendanceClassLeader = const [],
    this.startDate,
    this.endDate,
    this.showScreen = 1,
    this.attendanceWeek,
    this.attendanceMonth,
    this.attendanceDay,
  });
  @override
  List<Object?> get props => [
        attendanceClassTeacher,
        attendanceClassLeader,
        attendanceStatus,
        classTeacher,
        attendanceWeek,
        attendanceMonth,
        attendanceDay,
        endDate,
        startDate,
        showScreen,
      ];
  AttendanceState copyWith({
    List<AttendanceTeacher>? attendanceClassLeader,
    List<AttendanceTeacher>? attendanceClassTeacher,
    AttendanceWeek? attendanceDay,
    AttendanceWeek? attendanceMonth,
    int? showScreen,
    AttendanceStatus? attendanceStatus,
    List<ClassTeacher>? classTeacher,
    AttendanceWeek? attendanceWeek,
    String? startDate,
    String? endDate,
  }) {
    return AttendanceState(
      attendanceClassLeader:
          attendanceClassLeader ?? this.attendanceClassLeader,
      attendanceClassTeacher:
          attendanceClassTeacher ?? this.attendanceClassTeacher,
      attendanceDay: attendanceDay ?? this.attendanceDay,
      attendanceMonth: attendanceMonth ?? this.attendanceMonth,
      showScreen: showScreen ?? this.showScreen,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      attendanceWeek: attendanceWeek ?? this.attendanceWeek,
      classTeacher: classTeacher ?? this.classTeacher,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
    );
  }
}
