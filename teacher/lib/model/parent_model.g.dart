// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentModel _$ParentModelFromJson(Map<String, dynamic> json) => ParentModel(
      parentID: json['parent_id'] as int?,
      motherName: json['mother_name'] as String?,
      motherPhone: json['mother_phone'] as String?,
      fatherName: json['father_name'] as String?,
      fatherPhone: json['father_phone'] as String?,
    );

Map<String, dynamic> _$ParentModelToJson(ParentModel instance) =>
    <String, dynamic>{
      'parent_id': instance.parentID,
      'mother_name': instance.motherName,
      'mother_phone': instance.motherPhone,
      'father_name': instance.fatherName,
      'father_phone': instance.fatherPhone,
    };
