// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      name: json['name'] as String?,
      userKey: json['user_key'] as String?,
      userId: json['user_id'] as int?,
      schoolId: json['school_id'] as int?,
      pupilId: json['pupil_id'] as int?,
      type: json['type'] as int?,
      typeText: json['type_text'] as String?,
      parentId: json['parent_id'] as int?,
      parentName: json['parent_name'] as String?,
      learnYear: json['learn_year'] as String?,
      className: json['class_name'] as String?,
      schoolName: json['school_name'] as String?,
      schoolLogo: json['school_logo'] as String?,
      schoolBrand: json['school_brand'] as String?,
      capDaoTao: json['cap_dao_tao'] == null
          ? null
          : TrainingLevel.fromJson(json['cap_dao_tao'] as Map<String, dynamic>),
      email: json['email'] as String?,
      fatherName: json['father_name'] as String?,
      teacherId: json['teacher_id'] as int?,
      semester: json['semester'] as int?,
      children: json['children'] == null
          ? null
          : ChildrenModel.fromJson(json['children'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'name': instance.name,
      'user_key': instance.userKey,
      'user_id': instance.userId,
      'school_id': instance.schoolId,
      'pupil_id': instance.pupilId,
      'type': instance.type,
      'type_text': instance.typeText,
      'parent_id': instance.parentId,
      'parent_name': instance.parentName,
      'learn_year': instance.learnYear,
      'class_name': instance.className,
      'school_name': instance.schoolName,
      'school_logo': instance.schoolLogo,
      'school_brand': instance.schoolBrand,
      'cap_dao_tao': instance.capDaoTao,
      'email': instance.email,
      'father_name': instance.fatherName,
      'teacher_id': instance.teacherId,
      'semester': instance.semester,
      'children': instance.children,
    };
