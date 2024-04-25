import 'package:json_annotation/json_annotation.dart';
part 'plan_data_week_model.g.dart';

@JsonSerializable()
class PlanDataWeekModel {
  @JsonKey(name: 'PLAN_CONTENT')
  final String? planContent;
  @JsonKey(name: 'PLAN_CONTENT_DETAIL')
  final String? planContentDetail;
  @JsonKey(name: 'PLAN_TIME')
  final String? planTime;
  @JsonKey(name: 'PLAN_TEACHER_ID')
  final String? planTeacherId;
  @JsonKey(name: 'PLAN_TEACHER_NAME')
  final String? planTeacherName;

  PlanDataWeekModel({
    this.planContent,
    this.planContentDetail,
    this.planTime,
    this.planTeacherId,
    this.planTeacherName,
  });

  factory PlanDataWeekModel.fromJson(Map<String, dynamic> json) =>
      _$PlanDataWeekModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanDataWeekModelToJson(this);

  @override
  String toString() {
    return 'PlanDataWeekModel{planContent: $planContent, planContentDetail: $planContentDetail, planTime: $planTime, planTeacherId: $planTeacherId, planTeacherName: $planTeacherName}';
  }

  PlanDataWeekModel copyWith({
    String? planContent,
    String? planContentDetail,
    String? planTime,
    String? planTeacherId,
    String? planTeacherName,
  }) {
    return PlanDataWeekModel(
      planContent: planContent ?? this.planContent,
      planContentDetail: planContentDetail ?? this.planContentDetail,
      planTime: planTime ?? this.planTime,
      planTeacherId: planTeacherId ?? this.planTeacherId,
      planTeacherName: planTeacherName ?? this.planTeacherName,
    );
  }
}
