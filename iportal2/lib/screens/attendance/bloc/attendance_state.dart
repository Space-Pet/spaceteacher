part of 'attendance_bloc.dart';

enum AttendanceStatus {
  init,
  success,
  error,
  initWeek,
  successWeek,
  initMonth,
  successMonth
}

class AttendanceState extends Equatable {
  final ProfileInfo user;
  final List<AttendanceDay>? attendanceday;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final AttendanceStatus attendanceStatus;
  final DateTime? selectDate;
  const AttendanceState(
      {required this.user,
      this.selectDate,
      this.attendanceday,
      this.attendanceWeek,
      this.attendanceMonth,
      this.attendanceStatus = AttendanceStatus.init});
  @override
  List<Object?> get props =>
      [attendanceStatus, attendanceday, selectDate, user, attendanceWeek, attendanceMonth];

  AttendanceState copyWith(
      {List<AttendanceDay>? attendanceday,
      AttendanceStatus? attendanceStatus,
      ProfileInfo? user,
      DateTime? date,
      AttendanceWeek? attendanceWeek,
      AttendanceWeek? attendanceMonth}) {
    return AttendanceState(
      selectDate: date ?? this.selectDate,
        attendanceMonth: attendanceMonth ?? this.attendanceMonth,
        attendanceWeek: attendanceWeek ?? this.attendanceWeek,
        user: user ?? this.user,
        attendanceStatus: attendanceStatus ?? this.attendanceStatus,
        attendanceday: attendanceday ?? this.attendanceday);
  }
}
