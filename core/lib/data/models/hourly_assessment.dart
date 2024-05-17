import 'package:json_annotation/json_annotation.dart';
import 'hourly_assessment_detail.dart';

part 'hourly_assessment.g.dart';

@JsonSerializable()
class HourlyAssessment {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @JsonKey(name: 'teacher_fullname')
  final String? teacherFullname;
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @JsonKey(name: 'date_to')
  final String? dateTo;
  @JsonKey(name: 'class_id')
  final String? classId;
  @JsonKey(name: 'data')
  final List<HourlyAssessmentDetail> listHourlyAssessment;

  HourlyAssessment({
    this.userId,
    this.teacherId,
    this.teacherFullname,
    this.dateFrom,
    this.dateTo,
    this.classId,
    this.listHourlyAssessment = const [],
  });

  factory HourlyAssessment.fromJson(Map<String, dynamic> json) =>
      _$HourlyAssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyAssessmentToJson(this);

  @override
  String toString() {
    return 'HourlyAssessment{userId: $userId, teacherId: $teacherId, teacherFullname: $teacherFullname, dateFrom: $dateFrom, dateTo: $dateTo, classId: $classId, listHourlyAssessment: $listHourlyAssessment}';
  }

  HourlyAssessment copyWith({
    String? userId,
    String? teacherId,
    String? teacherFullname,
    String? dateFrom,
    String? dateTo,
    String? classId,
    List<HourlyAssessmentDetail>? listHourlyAssessment,
  }) {
    return HourlyAssessment(
      userId: userId ?? this.userId,
      teacherId: teacherId ?? this.teacherId,
      teacherFullname: teacherFullname ?? this.teacherFullname,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      classId: classId ?? this.classId,
      listHourlyAssessment: listHourlyAssessment ?? this.listHourlyAssessment,
    );
  }
}
