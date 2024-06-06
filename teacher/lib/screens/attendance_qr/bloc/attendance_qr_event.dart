part of 'attendance_qr_bloc.dart';

abstract class AttendanceQrEvent extends Equatable {
  const AttendanceQrEvent();

  @override
  List<Object?> get props => [];
}

class GetListAttendance extends AttendanceQrEvent {
  final int classId;
  final int numberOfClassPeriod;
  final int? subjectId;
  final String type;
  final String date;

  const GetListAttendance({
    this.subjectId,
    required this.classId,
    required this.date,
    required this.numberOfClassPeriod,
    required this.type,
  });

  @override
  List<Object?> get props => [
        subjectId,
        classId,
        date,
        numberOfClassPeriod,
        type,
      ];
}

class PostAttendance extends AttendanceQrEvent {
  final String type;
  final int numberOfClasspriod;
  final int classId;
  final int subject;
  final int roomId;
  final String roomTitle;
  final String date;
  final List<AttendanceDataList> attendanceData;
  const PostAttendance({
    required this.attendanceData,
    required this.classId,
    required this.date,
    required this.numberOfClasspriod,
    required this.roomId,
    required this.roomTitle,
    required this.subject,
    required this.type,
  });
  @override
  List<Object> get props => [
        attendanceData,
        type,
        numberOfClasspriod,
        classId,
        subject,
        roomId,
        roomTitle,
        date,
      ];
}

