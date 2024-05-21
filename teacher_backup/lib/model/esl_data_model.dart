import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/subject_esl_core_model.dart';
import 'package:teacher/model/subject_esl_model.dart';
part 'esl_data_model.g.dart';

@JsonSerializable()
class EslDataModel {
  @JsonKey(name: 'MARK_ESL_TYPE')
  final String? markType;
  @JsonKey(name: 'SUBJECT_ESL')
  final SubjectESLModel subject;
  @JsonKey(name: 'SUBJECT_ESL_CORE')
  final SubjectEslCoreModel subjectCore;

  EslDataModel(
      {this.markType, required this.subject, required this.subjectCore});

  factory EslDataModel.fromJson(Map<String, dynamic> json) =>
      _$EslDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EslDataModelToJson(this);

  @override
  String toString() {
    return 'EslDataModel{markType: $markType, subject: $subject, subjectCore: $subjectCore}';
  }

  EslDataModel copyWith({
    String? markType,
    SubjectESLModel? subject,
    SubjectEslCoreModel? subjectCore,
  }) {
    return EslDataModel(
      markType: markType ?? this.markType,
      subject: subject ?? this.subject,
      subjectCore: subjectCore ?? this.subjectCore,
    );
  }
}
