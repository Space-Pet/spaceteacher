part of 'attendance_qr_bloc.dart';

enum AttendanceQrStatus {
  init,
  loadingGetList,
  loadingPostAttendance,
  successGetList,
  successPostAttendance,
  fail,
  failPost,
}

class AttendanceQrState extends Equatable {
  final List<ListAttendanceModel> listAttendance;
  final AttendanceQrStatus attendanceQrStatus;
  final String message;
  const AttendanceQrState({
    this.attendanceQrStatus = AttendanceQrStatus.init,
    this.listAttendance = const [],
    this.message = '',
  });
  @override
  List<Object> get props => [
        attendanceQrStatus,
        listAttendance,
        message,
      ];
  AttendanceQrState copyWith({
    String? message,
    List<ListAttendanceModel>? listAttendance,
    AttendanceQrStatus? attendanceQrStatus,
  }) {
    return AttendanceQrState(
      message: message ?? this.message,
      attendanceQrStatus: attendanceQrStatus ?? this.attendanceQrStatus,
      listAttendance: listAttendance ?? this.listAttendance,
    );
  }
}
