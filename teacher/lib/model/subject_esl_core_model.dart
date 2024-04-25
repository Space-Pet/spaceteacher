import 'package:json_annotation/json_annotation.dart';
part 'subject_esl_core_model.g.dart';

@JsonSerializable()
class SubjectEslCoreModel {
  @JsonKey(name: 'SUBJECT_ESL_CORE_ID')
  final String? id;
  @JsonKey(name: 'SUBJECT_ESL_CORE_NAME')
  final String? name;
  @JsonKey(name: 'SUBJECT_ESL_CORE_VALUE')
  final String? value;
  @JsonKey(name: 'SUBJECT_ESL_CORE_COMMENT')
  final String? comment;

  SubjectEslCoreModel({this.id, this.name, this.value, this.comment});

  factory SubjectEslCoreModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectEslCoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectEslCoreModelToJson(this);

  @override
  String toString() {
    return 'SubjectEslCoreModel{id: $id, name: $name, value: $value, comment: $comment}';
  }

  SubjectEslCoreModel copyWith({
    String? id,
    String? name,
    String? value,
    String? comment,
  }) {
    return SubjectEslCoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      comment: comment ?? this.comment,
    );
  }
}
