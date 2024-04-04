import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/class_model.dart';
import 'package:teacher/model/parent_model.dart';
import 'package:teacher/model/pupil_model.dart';
import 'package:teacher/model/school_model.dart';
part 'student_model.g.dart';

@JsonSerializable()
class StudentModel {
  @JsonKey(name: 'pupil')
  final PupilModel? pupilModel;
  @JsonKey(name: 'class')
  final ClassModel? classModel;
  @JsonKey(name: 'school')
  final SchoolModel? school;
  @JsonKey(name: 'parent')
  final ParentModel? parent;

  StudentModel({
    this.pupilModel,
    this.classModel,
    this.school,
    this.parent,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  StudentModel copyWith({
    PupilModel? pupilModel,
    ClassModel? classModel,
    SchoolModel? school,
    ParentModel? parent,
  }) {
    return StudentModel(
      pupilModel: pupilModel ?? this.pupilModel,
      classModel: classModel ?? this.classModel,
      school: school ?? this.school,
      parent: parent ?? this.parent,
    );
  }
}
