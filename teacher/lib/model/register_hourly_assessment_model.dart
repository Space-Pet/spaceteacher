import 'package:json_annotation/json_annotation.dart';
part 'register_hourly_assessment_model.g.dart';

@JsonSerializable()
class RegisterHourlyAssessmentModel {
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'txt_date')
  final String? txtDate;
  @JsonKey(name: 'SCHOOL_ID')
  final int? schoolId;
  @JsonKey(name: 'TEACHER_ID')
  final int? teacherId;
  @JsonKey(name: 'TIET_NUM')
  final int? periodNum;
  @JsonKey(name: 'CLASS_ID')
  final int? classId;
  @JsonKey(name: 'SUBJECT_ID')
  final int? subjectId;
  @JsonKey(name: 'lesson_register_id')
  final int? lessonRegisterId;
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;

  RegisterHourlyAssessmentModel({
    this.userKey,
    this.txtDate,
    this.schoolId,
    this.teacherId,
    this.periodNum,
    this.classId,
    this.subjectId,
    this.lessonRegisterId,
    this.status,
    this.statusNote,
  });

  factory RegisterHourlyAssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterHourlyAssessmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterHourlyAssessmentModelToJson(this);

  @override
  String toString() {
    return 'RegisterHourlyAssessmentModel{userKey: $userKey, txtDate: $txtDate, schoolId: $schoolId, teacherId: $teacherId, periodNum: $periodNum, classId: $classId, subjectId: $subjectId, lessonRegisterId: $lessonRegisterId, status: $status, statusNote: $statusNote}';
  }

  RegisterHourlyAssessmentModel copyWith({
    String? userKey,
    String? txtDate,
    int? schoolId,
    int? teacherId,
    int? periodNum,
    int? classId,
    int? subjectId,
    int? lessonRegisterId,
    String? status,
    String? statusNote,
  }) {
    return RegisterHourlyAssessmentModel(
      userKey: userKey ?? this.userKey,
      txtDate: txtDate ?? this.txtDate,
      schoolId: schoolId ?? this.schoolId,
      teacherId: teacherId ?? this.teacherId,
      periodNum: periodNum ?? this.periodNum,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      lessonRegisterId: lessonRegisterId ?? this.lessonRegisterId,
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
    );
  }
}
