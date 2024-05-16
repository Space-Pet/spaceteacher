import 'package:json_annotation/json_annotation.dart';
part 'status_hourly_assessment_response_model.g.dart';

@JsonSerializable()
class StatusHourlyAssessmentModel {
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

  StatusHourlyAssessmentModel({
    this.userId,
    this.userKey,
    this.lessonRegisterId,
    this.teacherId,
    this.teacherFullName,
    this.status,
    this.statusNote,
  });

  factory StatusHourlyAssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$StatusHourlyAssessmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusHourlyAssessmentModelToJson(this);

  @override
  String toString() {
    return 'StatusHourlyAssessmentModel{userId: $userId, teacherId: $teacherId, teacherFullName: $teacherFullName, status: $status, statusNote: $statusNote}';
  }

  StatusHourlyAssessmentModel copyWith({
    String? userId,
    String? userKey,
    String? lessonRegisterId,
    String? teacherId,
    String? teacherFullName,
    String? status,
    String? statusNote,
  }) {
    return StatusHourlyAssessmentModel(
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
