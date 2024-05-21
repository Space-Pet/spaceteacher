part of 'attendance_bloc.dart';

enum AttendanceStatus {
  init,
  initType,
  successType,
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
  final String? type;
  const AttendanceState(
      {required this.user,
      this.selectDate,
      this.type,
      this.attendanceday,
      this.attendanceWeek,
      this.attendanceMonth,
      this.attendanceStatus = AttendanceStatus.init});
  @override
  List<Object?> get props => [
        type,
        attendanceStatus,
        attendanceday,
        selectDate,
        user,
        attendanceWeek,
        attendanceMonth
      ];

  AttendanceState copyWith(
      {List<AttendanceDay>? attendanceday,
      AttendanceStatus? attendanceStatus,
      ProfileInfo? user,
      String? type,
      DateTime? date,
      AttendanceWeek? attendanceWeek,
      AttendanceWeek? attendanceMonth}) {
    return AttendanceState(
        type: type ?? this.type,
        selectDate: date ?? this.selectDate,
        attendanceMonth: attendanceMonth ?? this.attendanceMonth,
        attendanceWeek: attendanceWeek ?? this.attendanceWeek,
        user: user ?? this.user,
        attendanceStatus: attendanceStatus ?? this.attendanceStatus,
        attendanceday: attendanceday ?? this.attendanceday);
  }
}
