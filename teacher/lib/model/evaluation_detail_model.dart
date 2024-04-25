import 'package:json_annotation/json_annotation.dart';
part 'evaluation_detail_model.g.dart';

@JsonSerializable()
class EvaluationDetailModel {
  final int? id;
  final String? title;
  final String? description;
  final String? language;
  @JsonKey(name: 'class_title')
  final String? classTitle;
  @JsonKey(name: 'school_brand')
  final String? schoolBrand;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  final int? status;
  final int? semester;

  EvaluationDetailModel({
    this.id,
    this.title,
    this.description,
    this.language,
    this.classTitle,
    this.schoolBrand,
    this.learnYear,
    this.status,
    this.semester,
  });

  factory EvaluationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationDetailModelToJson(this);

  @override
  String toString() {
    return 'EvaluationDetailModel{id: $id, title: $title, description: $description, language: $language, classTitle: $classTitle, schoolBrand: $schoolBrand, learnYear: $learnYear, status: $status, semester: $semester}';
  }

  EvaluationDetailModel copyWith({
    int? id,
    String? title,
    String? description,
    String? language,
    String? classTitle,
    String? schoolBrand,
    String? learnYear,
    int? status,
    int? semester,
  }) {
    return EvaluationDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      classTitle: classTitle ?? this.classTitle,
      schoolBrand: schoolBrand ?? this.schoolBrand,
      learnYear: learnYear ?? this.learnYear,
      status: status ?? this.status,
      semester: semester ?? this.semester,
    );
  }
}
