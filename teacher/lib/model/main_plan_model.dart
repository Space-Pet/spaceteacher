import 'package:json_annotation/json_annotation.dart';
part 'main_plan_model.g.dart';

@JsonSerializable()
class MainPlanModel {
  @JsonKey(name: 'CLASS_ID')
  final int? classId;
  @JsonKey(name: 'CLASS_NAME')
  final String? className;
  @JsonKey(name: 'MAIN_PLAN_TITLE')
  final String? mainPlanTitle;
  @JsonKey(name: 'MAIN_PLAN_BODY')
  final String? mainPlanBody;

  MainPlanModel({
    this.classId,
    this.className,
    this.mainPlanTitle,
    this.mainPlanBody,
  });

  factory MainPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MainPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainPlanModelToJson(this);

  @override
  String toString() {
    return 'MainPlanModel{classId: $classId, className: $className, mainPlanTitle: $mainPlanTitle, mainPlanBody: $mainPlanBody}';
  }

  MainPlanModel copyWith({
    int? classId,
    String? className,
    String? mainPlanTitle,
    String? mainPlanBody,
  }) {
    return MainPlanModel(
      classId: classId ?? this.classId,
      className: className ?? this.className,
      mainPlanTitle: mainPlanTitle ?? this.mainPlanTitle,
      mainPlanBody: mainPlanBody ?? this.mainPlanBody,
    );
  }
}
