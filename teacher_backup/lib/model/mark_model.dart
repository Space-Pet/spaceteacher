import 'package:json_annotation/json_annotation.dart';
part 'mark_model.g.dart';

@JsonSerializable()
class MarkModel {
  final int? id;
  final String? title;
  final String? description;
  final int? value;
  @JsonKey(name: 'evaluation_form_id')
  final int? evaluationFormID;
  @JsonKey(name: 'school_id')
  final int? schoolID;
  @JsonKey(name: 'user_id')
  final int? userID;

  MarkModel({
    this.id,
    this.title,
    this.description,
    this.value,
    this.evaluationFormID,
    this.schoolID,
    this.userID,
  });

  factory MarkModel.fromJson(Map<String, dynamic> json) =>
      _$MarkModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkModelToJson(this);

  @override
  String toString() {
    return 'MarkModel{id: $id, title: $title, description: $description, value: $value, evaluationFormID: $evaluationFormID, schoolID: $schoolID, userID: $userID}';
  }

  MarkModel copyWith({
    int? id,
    String? title,
    String? description,
    int? value,
    int? evaluationFormID,
    int? schoolID,
    int? userID,
  }) {
    return MarkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      value: value ?? this.value,
      evaluationFormID: evaluationFormID ?? this.evaluationFormID,
      schoolID: schoolID ?? this.schoolID,
      userID: userID ?? this.userID,
    );
  }
}
