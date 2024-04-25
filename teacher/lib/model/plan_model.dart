import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/detail_plan_model.dart';
import 'package:teacher/model/main_plan_model.dart';
part 'plan_model.g.dart';

@JsonSerializable()
class PlanModel {
  @JsonKey(name: 'main_plan')
  final List<MainPlanModel>? mainPlan;
  @JsonKey(name: 'detail_plan')
  final List<DetailPlanModel>? detailPlan;

  PlanModel({
    this.mainPlan,
    this.detailPlan,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _$PlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanModelToJson(this);

  @override
  String toString() {
    return 'PlanModel{mainPlan: $mainPlan, detailPlan: $detailPlan}';
  }

  PlanModel copyWith({
    List<MainPlanModel>? mainPlan,
    List<DetailPlanModel>? detailPlan,
  }) {
    return PlanModel(
      mainPlan: mainPlan ?? this.mainPlan,
      detailPlan: detailPlan ?? this.detailPlan,
    );
  }
}
