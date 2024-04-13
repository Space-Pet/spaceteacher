import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/plan_data_week_model.dart';

part 'detail_plan_model.g.dart';

@JsonSerializable()
class DetailPlanModel {
  @JsonKey(name: 'PLANMN_NGAY')
  final String? planmnNgay;
  @JsonKey(name: 'PLANMN_WEEK')
  final String? planmnWeek;
  @JsonKey(name: 'PLANMN_DATA_IN_WEEK')
  final List<PlanDataWeekModel>? planmnDataInWeek;

  DetailPlanModel({
    this.planmnNgay,
    this.planmnWeek,
    this.planmnDataInWeek,
  });

  factory DetailPlanModel.fromJson(Map<String, dynamic> json) =>
      _$DetailPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailPlanModelToJson(this);

  @override
  String toString() {
    return 'DetailPlanModel{planmnNgay: $planmnNgay, planmnWeek: $planmnWeek, planmnDataInWeek: $planmnDataInWeek}';
  }

  DetailPlanModel copyWith({
    String? planmnNgay,
    String? planmnWeek,
    List<PlanDataWeekModel>? planmnDataInWeek,
  }) {
    return DetailPlanModel(
      planmnNgay: planmnNgay ?? this.planmnNgay,
      planmnWeek: planmnWeek ?? this.planmnWeek,
      planmnDataInWeek: planmnDataInWeek ?? this.planmnDataInWeek,
    );
  }
}
