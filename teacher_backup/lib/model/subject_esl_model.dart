import 'package:json_annotation/json_annotation.dart';
part 'subject_esl_model.g.dart';

@JsonSerializable()
class SubjectESLModel {
  @JsonKey(name: 'SUBJECT_ESL_ID')
  final String? id;
  @JsonKey(name: 'SUBJECT_ESL_NAME')
  final String? name;

  SubjectESLModel({this.id, this.name});

  factory SubjectESLModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectESLModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectESLModelToJson(this);

  @override
  String toString() {
    return 'SubjectESLModel{id: $id, name: $name}';
  }

  SubjectESLModel copyWith({
    String? id,
    String? name,
  }) {
    return SubjectESLModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
