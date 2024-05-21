import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/evaluation_detail_model.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/meta_model.dart';
part 'evaluation_form_model.g.dart';

@JsonSerializable()
class EvaluationFormModel {
  @JsonKey(name: 'data')
  final List<EvaluationDetailModel>? evaluationDetailModels;
  final Meta? meta;
  final Links? links;

  EvaluationFormModel({
    this.evaluationDetailModels,
    this.meta,
    this.links,
  });

  factory EvaluationFormModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationFormModelToJson(this);

  @override
  String toString() {
    return 'EvaluationFormModel{evaluationDetailModels: $evaluationDetailModels, meta: $meta, links: $links}';
  }

  EvaluationFormModel copyWith({
    List<EvaluationDetailModel>? evaluationDetailModels,
    Meta? meta,
    Links? links,
  }) {
    return EvaluationFormModel(
      evaluationDetailModels:
          evaluationDetailModels ?? this.evaluationDetailModels,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }
}
