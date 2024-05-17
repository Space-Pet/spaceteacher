import 'package:json_annotation/json_annotation.dart';
part 'status_hourly_assessment.g.dart';

@JsonSerializable()
class StatusHourlyAssessment {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'lesson_register_id')
  final String? lessonRegisterId;
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @JsonKey(name: 'teacher_fullname')
  final String? teacherFullName;
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;

  StatusHourlyAssessment({
    this.userId,
    this.userKey,
    this.lessonRegisterId,
    this.teacherId,
    this.teacherFullName,
    this.status,
    this.statusNote,
  });

  factory StatusHourlyAssessment.fromJson(Map<String, dynamic> json) =>
      _$StatusHourlyAssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$StatusHourlyAssessmentToJson(this);

  @override
  String toString() {
    return 'StatusHourlyAssessment{userId: $userId, teacherId: $teacherId, teacherFullName: $teacherFullName, status: $status, statusNote: $statusNote}';
  }

  StatusHourlyAssessment copyWith({
    String? userId,
    String? userKey,
    String? lessonRegisterId,
    String? teacherId,
    String? teacherFullName,
    String? status,
    String? statusNote,
  }) {
    return StatusHourlyAssessment(
      userId: userId ?? this.userId,
      userKey: userKey ?? this.userKey,
      lessonRegisterId: lessonRegisterId ?? this.lessonRegisterId,
      teacherId: teacherId ?? this.teacherId,
      teacherFullName: teacherFullName ?? this.teacherFullName,
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
    );
  }
}
