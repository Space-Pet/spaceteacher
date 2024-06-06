import 'package:json_annotation/json_annotation.dart';

part 'attendance_teacher.g.dart';

@JsonSerializable()
class AttendanceTeacher {
  @JsonKey(name: 'school_id')
  final int schoolId;
  @JsonKey(name: 'class_id')
  final int classId;
  @JsonKey(name: 'class_title')
  final String classTitle;
  @JsonKey(name: 'teacher_id')
  final int teacherId;
  @JsonKey(name: 'teacher_name')
  final String teacherName;
  @JsonKey(name: 'subject_id')
  final int subjectId;
  @JsonKey(name: 'subject_name')
  final String subjectName;
  @JsonKey(name: 'number_of_class_period')
  final int numberOfClassPeriod;
  final int semester;
  @JsonKey(name: 'room_id')
  final int roomId;
  @JsonKey(name: 'room_title')
  final String roomTitle;
  @JsonKey(name: 'attendance_type')
  final String attendanceType;
  final String date;
  @JsonKey(name: 'created_date')
  final String createdDate;
  @JsonKey(name: 'attendance_data')
  final AttendanceData? attendanceData;

  AttendanceTeacher({
    required this.schoolId,
    required this.classId,
    required this.classTitle,
    required this.teacherId,
    required this.teacherName,
    required this.subjectId,
    required this.subjectName,
    required this.numberOfClassPeriod,
    required this.semester,
    required this.roomId,
    required this.roomTitle,
    required this.attendanceType,
    required this.date,
    required this.createdDate,
    this.attendanceData,
  });

  factory AttendanceTeacher.fromJson(Map<String, dynamic> json) =>
      _$AttendanceTeacherFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceTeacherToJson(this);
}

@JsonSerializable()
class AttendanceData {
  final List<AttendanceDetail>? present;
  final List<AttendanceDetail>? absence;
  @JsonKey(name: 'leave_application')
  final List<AttendanceDetail>? leaveApplication;

  AttendanceData({
    this.present,
    this.absence,
    this.leaveApplication,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataToJson(this);
}

@JsonSerializable()
class AttendanceDetail {
  final int id;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @JsonKey(name: 'pupil_name')
  final String pupilName;
  @JsonKey(name: 'number_of_class_period')
  final int numberOfClassPeriod;
  final String time;

  AttendanceDetail({
    required this.id,
    required this.pupilId,
    required this.pupilName,
    required this.numberOfClassPeriod,
    required this.time,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailToJson(this);
}
