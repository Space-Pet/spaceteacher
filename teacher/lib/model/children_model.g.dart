// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildrenModel _$ChildrenModelFromJson(Map<String, dynamic> json) =>
    ChildrenModel(
      pupilID: (json['pupil_id'] as num?)?.toInt(),
      userID: json['user_id'] as String?,
      birthday: json['birthday'] as String?,
      schoolID: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      classID: (json['class_id'] as num?)?.toInt(),
      customerID: (json['customer_id'] as num?)?.toInt(),
      learnYear: json['learn_year'] as String?,
      fullName: json['full_name'] as String?,
      userKey: json['user_key'] as String?,
      parentID: (json['parent_id'] as num?)?.toInt(),
      className: json['class_name'] as String?,
      urlImageModel: json['url_image'] == null
          ? null
          : UrlImageModel.fromJson(json['url_image'] as Map<String, dynamic>),
      email: json['email'] as String?,
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$ChildrenModelToJson(ChildrenModel instance) =>
    <String, dynamic>{
      'pupil_id': instance.pupilID,
      'user_id': instance.userID,
      'birthday': instance.birthday,
      'school_id': instance.schoolID,
      'school_name': instance.schoolName,
      'class_id': instance.classID,
      'customer_id': instance.customerID,
      'learn_year': instance.learnYear,
      'full_name': instance.fullName,
      'user_key': instance.userKey,
      'parent_id': instance.parentID,
      'class_name': instance.className,
      'url_image': instance.urlImageModel,
      'email': instance.email,
      'identifier': instance.identifier,
    };
