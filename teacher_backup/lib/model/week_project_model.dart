import 'package:json_annotation/json_annotation.dart';

import 'package:teacher/model/plan_model.dart';
part 'week_project_model.g.dart';

@JsonSerializable()
class WeekProjectModel {
  @JsonKey(name: 'txt_week')
  final String? txtWeek;
  @JsonKey(name: 'txt_begin_day')
  final String? txtBeginDay;
  @JsonKey(name: 'txt_end_day')
  final String? txtEndDay;
  @JsonKey(name: 'txt_pre_week')
  final String? txtPreWeek;
  @JsonKey(name: 'txt_next_week')
  final String? txtNextWeek;
  @JsonKey(name: 'txt_class_name')
  final String? txtClassName;
  @JsonKey(name: 'data')
  final PlanModel? planData;

  WeekProjectModel({
    this.txtWeek,
    this.txtBeginDay,
    this.txtEndDay,
    this.txtPreWeek,
    this.txtNextWeek,
    this.txtClassName,
    this.planData,
  });

  factory WeekProjectModel.fromJson(Map<String, dynamic> json) =>
      _$WeekProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeekProjectModelToJson(this);

  @override
  String toString() {
    return 'WeekProjectModel{txtWeek: $txtWeek, txtBeginDay: $txtBeginDay, txtEndDay: $txtEndDay, txtPreWeek: $txtPreWeek, txtNextWeek: $txtNextWeek, txtClassName: $txtClassName, planData: $planData}';
  }

  WeekProjectModel copyWith({
    String? txtWeek,
    String? txtBeginDay,
    String? txtEndDay,
    String? txtPreWeek,
    String? txtNextWeek,
    String? txtClassName,
    PlanModel? planData,
  }) {
    return WeekProjectModel(
      txtWeek: txtWeek ?? this.txtWeek,
      txtBeginDay: txtBeginDay ?? this.txtBeginDay,
      txtEndDay: txtEndDay ?? this.txtEndDay,
      txtPreWeek: txtPreWeek ?? this.txtPreWeek,
      txtNextWeek: txtNextWeek ?? this.txtNextWeek,
      txtClassName: txtClassName ?? this.txtClassName,
      planData: planData ?? this.planData,
    );
  }
}
