import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/hourly_assessment_detail_model.dart';

part 'hourly_assessment_model.g.dart';

@JsonSerializable()
class HourlyAssessmentModel {
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
  final List<HourlyAssessmentDetailModel> listHourlyAssessment;

  HourlyAssessmentModel({
    this.userId,
    this.teacherId,
    this.teacherFullname,
    this.dateFrom,
    this.dateTo,
    this.classId,
    this.listHourlyAssessment = const [],
  });

  factory HourlyAssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyAssessmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyAssessmentModelToJson(this);

  @override
  String toString() {
    return 'HourlyAssessmentModel{userId: $userId, teacherId: $teacherId, teacherFullname: $teacherFullname, dateFrom: $dateFrom, dateTo: $dateTo, classId: $classId, listHourlyAssessment: $listHourlyAssessment}';
  }

  HourlyAssessmentModel copyWith({
    String? userId,
    String? teacherId,
    String? teacherFullname,
    String? dateFrom,
    String? dateTo,
    String? classId,
    List<HourlyAssessmentDetailModel>? listHourlyAssessment,
  }) {
    return HourlyAssessmentModel(
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
