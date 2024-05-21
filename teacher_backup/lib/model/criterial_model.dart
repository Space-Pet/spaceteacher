import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/criterial_result_model.dart';
import 'package:teacher/model/mark_model.dart';
part 'criterial_model.g.dart';

@JsonSerializable()
class CriterialModel {
  final int? id;
  @JsonKey(name: 'evaluation_form_id')
  final int? evaluationFormID;
  @JsonKey(name: 'criterial_id')
  final int? criterialID;
  @JsonKey(name: 'criterial_category_id')
  final int? criterialCategoryID;
  final int? priority;
  @JsonKey(name: 'user_id')
  final int? userID;
  @JsonKey(name: 'criterial_title')
  final String? criterialTitle;
  @JsonKey(name: 'result')
  final List<CriterialResultModel>? resultModel;
  @JsonKey(name: 'list_marks')
  final List<MarkModel>? listMarks;

  CriterialModel({
    this.id,
    this.evaluationFormID,
    this.criterialID,
    this.criterialCategoryID,
    this.priority,
    this.userID,
    this.criterialTitle,
    this.resultModel,
    this.listMarks,
  });

  factory CriterialModel.fromJson(Map<String, dynamic> json) =>
      _$CriterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$CriterialModelToJson(this);

  @override
  String toString() {
    return 'CriterialModel{id: $id, evaluationFormID: $evaluationFormID, criterialID: $criterialID, criterialCategoryID: $criterialCategoryID, priority: $priority, userID: $userID, criterialTitle: $criterialTitle, resultModel: $resultModel, listMarks: $listMarks}';
  }

  CriterialModel copyWith({
    int? id,
    int? evaluationFormID,
    int? criterialID,
    int? criterialCategoryID,
    int? priority,
    int? userID,
    String? criterialTitle,
    List<CriterialResultModel>? resultModel,
    List<MarkModel>? listMarks,
  }) {
    return CriterialModel(
      id: id ?? this.id,
      evaluationFormID: evaluationFormID ?? this.evaluationFormID,
      criterialID: criterialID ?? this.criterialID,
      criterialCategoryID: criterialCategoryID ?? this.criterialCategoryID,
      priority: priority ?? this.priority,
      userID: userID ?? this.userID,
      criterialTitle: criterialTitle ?? this.criterialTitle,
      resultModel: resultModel ?? this.resultModel,
      listMarks: listMarks ?? this.listMarks,
    );
  }
}
