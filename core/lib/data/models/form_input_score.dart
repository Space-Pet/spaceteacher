import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_input_score.g.dart';

@JsonSerializable()
class FormInputScore {
  @JsonKey(name: 'cap_dao_tao')
  final String? capDaoTao;
  final List<PupilItem>? items;

  FormInputScore({this.capDaoTao, this.items});

  factory FormInputScore.fromJson(Map<String, dynamic> json) =>
      _$FormInputScoreFromJson(json);

  Map<String, dynamic> toJson() => _$FormInputScoreToJson(this);

  // Factory method for default values when JSON is null
  factory FormInputScore.empty() {
    return FormInputScore(
      capDaoTao: '',
      items: [],
    );
  }
}

@JsonSerializable()
class PupilItem {
  @JsonKey(name: 'pupil_id')
  final int? pupilId;
  @JsonKey(name: 'pupil_name')
  final String? pupilName;
  @JsonKey(name: 'class_id')
  final int? classId;
  final int? coefficient;
  final int? semester;
  @JsonKey(name: 'subject_id')
  final int? subjectId;
  @JsonKey(name: 'mark_type')
  final MarkType? markType;
  @JsonKey(name: 'study_goals')
  final StudyGoals? studyGoals;

  PupilItem({
    this.pupilId,
    this.pupilName,
    this.classId,
    this.coefficient,
    this.semester,
    this.subjectId,
    this.markType,
    this.studyGoals,
  });

  factory PupilItem.fromJson(Map<String, dynamic> json) =>
      _$PupilItemFromJson(json);

  Map<String, dynamic> toJson() => _$PupilItemToJson(this);

  // Factory method for default values when JSON is null
  factory PupilItem.withDefaults(Map<String, dynamic> json) {
    return PupilItem(
      pupilId: json['pupil_id'] ?? 0,
      pupilName: json['pupil_name'] ?? '',
      classId: json['class_id'] ?? 0,
      coefficient: json['coefficient'] ?? 0,
      semester: json['semester'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      markType: json['mark_type'] != null
          ? MarkType.withDefaults(json['mark_type'] as Map<String, dynamic>)
          : MarkType.withDefaults({}),
      studyGoals: json['study_goals'] != null
          ? StudyGoals.withDefaults(json['study_goals'] as Map<String, dynamic>)
          : StudyGoals.withDefaults({}),
    );
  }
}

@JsonSerializable()
class MarkType {
  final int? value;
  final String? title;
  final List<MarkTypeItem>? items;

  MarkType({this.value, this.title, this.items});

  factory MarkType.fromJson(Map<String, dynamic> json) =>
      _$MarkTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MarkTypeToJson(this);

  // Factory method for default values when JSON is null
  factory MarkType.withDefaults(Map<String, dynamic> json) {
    return MarkType(
      value: json['value'] ?? 0,
      title: json['title'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => MarkTypeItem.withDefaults(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

@JsonSerializable()
class MarkTypeItem {
  final int? value;
  final String? text;

  MarkTypeItem({this.value, this.text});

  factory MarkTypeItem.fromJson(Map<String, dynamic> json) =>
      _$MarkTypeItemFromJson(json);

  Map<String, dynamic> toJson() => _$MarkTypeItemToJson(this);

  // Factory method for default values when JSON is null
  factory MarkTypeItem.withDefaults(Map<String, dynamic> json) {
    return MarkTypeItem(
      value: json['value'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}

@JsonSerializable()
class StudyGoals {
  final String? type;
  final List<StudyGoalsOption>? option;

  StudyGoals({this.type, this.option});

  factory StudyGoals.fromJson(Map<String, dynamic> json) =>
      _$StudyGoalsFromJson(json);

  Map<String, dynamic> toJson() => _$StudyGoalsToJson(this);

  // Factory method for default values when JSON is null
  factory StudyGoals.withDefaults(Map<String, dynamic> json) {
    return StudyGoals(
      type: json['type'] ?? '',
      option: (json['option'] as List<dynamic>?)
              ?.map((e) => StudyGoalsOption.withDefaults(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

@JsonSerializable()
class StudyGoalsOption {
  final String? value;
  final String? text;

  StudyGoalsOption({this.value, this.text});

  factory StudyGoalsOption.fromJson(Map<String, dynamic> json) =>
      _$StudyGoalsOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StudyGoalsOptionToJson(this);

  // Factory method for default values when JSON is null
  factory StudyGoalsOption.withDefaults(Map<String, dynamic> json) {
    return StudyGoalsOption(
      value: json['value'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
