import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/criterial_model.dart';
part 'student_result_item_model.g.dart';

@JsonSerializable()
class StudentResultItem {
  final int? id;
  final String? title;

  @JsonKey(name: 'parent_id')
  final int? parentID;
  @JsonKey(name: 'evaluation_form_id')
  final int? evaluationFormID;
  final int? priority;
  @JsonKey(name: 'children_items')
  final List<StudentResultItem>? studentResultItems;

  @JsonKey(name: 'list_criterial')
  final List<CriterialModel>? listCriterial;

  StudentResultItem({
    this.id,
    this.title,
    this.parentID,
    this.evaluationFormID,
    this.priority,
    this.studentResultItems,
    this.listCriterial,
  });

  factory StudentResultItem.fromJson(Map<String, dynamic> json) =>
      _$StudentResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$StudentResultItemToJson(this);

  @override
  String toString() {
    return 'StudentResultItem{id: $id, title: $title, parentID: $parentID, evaluationFormID: $evaluationFormID, priority: $priority, studentResultItems: $studentResultItems, listCriterial: $listCriterial}';
  }

  StudentResultItem copyWith({
    int? id,
    String? title,
    int? parentID,
    int? evaluationFormID,
    int? priority,
    List<StudentResultItem>? studentResultItems,
    List<CriterialModel>? listCriterial,
  }) {
    return StudentResultItem(
      id: id ?? this.id,
      title: title ?? this.title,
      parentID: parentID ?? this.parentID,
      evaluationFormID: evaluationFormID ?? this.evaluationFormID,
      priority: priority ?? this.priority,
      studentResultItems: studentResultItems ?? this.studentResultItems,
      listCriterial: listCriterial ?? this.listCriterial,
    );
  }
}
