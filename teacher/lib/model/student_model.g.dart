// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      pupilModel: json['pupil'] == null
          ? null
          : PupilModel.fromJson(json['pupil'] as Map<String, dynamic>),
      classModel: json['class'] == null
          ? null
          : ClassModel.fromJson(json['class'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : SchoolModel.fromJson(json['school'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : ParentModel.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'pupil': instance.pupilModel,
      'class': instance.classModel,
      'school': instance.school,
      'parent': instance.parent,
    };
