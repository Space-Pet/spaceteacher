import 'package:json_annotation/json_annotation.dart';
part 'hourly_assessment_detail_model.g.dart';

@JsonSerializable()
class HourlyAssessmentDetailModel {
  @JsonKey(name: 'SCHOOL_ID')
  final String? schoolId;
  @JsonKey(name: 'TIET_NUM')
  final String? periodNum;
  @JsonKey(name: 'CLASS_ID')
  final String? classId;
  @JsonKey(name: 'CLASS_NAME')
  final String? className;
  @JsonKey(name: 'ROOM_ID')
  final String? roomId;
  @JsonKey(name: 'ROOM_NAME')
  final String? roomName;
  @JsonKey(name: 'SUBJECT_ID')
  final String? subjectId;
  @JsonKey(name: 'SUBJECT_NAME')
  final String? subjectName;
  @JsonKey(name: 'TEACHER_ID')
  final String? teacherId;
  @JsonKey(name: 'TEACHER_FULLNAME')
  final String? teacherFullName;
  @JsonKey(name: 'WEEK_DAY')
  final String? weekDay;

  HourlyAssessmentDetailModel({
    this.schoolId,
    this.periodNum,
    this.classId,
    this.className,
    this.roomId,
    this.roomName,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherFullName,
    this.weekDay,
  });

  factory HourlyAssessmentDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyAssessmentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyAssessmentDetailModelToJson(this);

  @override
  String toString() {
    return 'HourlyAssessmentDetailModel{schoolId: $schoolId, periodNum: $periodNum, classId: $classId, className: $className, roomId: $roomId, roomName: $roomName, subjectId: $subjectId, subjectName: $subjectName, teacherId: $teacherId, teacherFullName: $teacherFullName, weekDay: $weekDay}';
  }

  HourlyAssessmentDetailModel copyWith({
    String? schoolId,
    String? periodNum,
    String? classId,
    String? className,
    String? roomId,
    String? roomName,
    String? subjectId,
    String? subjectName,
    String? teacherId,
    String? teacherFullName,
    String? weekDay,
  }) {
    return HourlyAssessmentDetailModel(
      schoolId: schoolId ?? this.schoolId,
      periodNum: periodNum ?? this.periodNum,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      teacherId: teacherId ?? this.teacherId,
      teacherFullName: teacherFullName ?? this.teacherFullName,
      weekDay: weekDay ?? this.weekDay,
    );
  }
}
