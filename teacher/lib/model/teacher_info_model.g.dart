// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherInfo _$TeacherInfoFromJson(Map<String, dynamic> json) => TeacherInfo(
      teacherId: (json['teacher_id'] as num?)?.toInt(),
      userId: json['user_id'] as String?,
      birthday: json['birthday'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      schoolName: json['school_name'] as String?,
      fullName: json['full_name'] as String?,
      userKey: json['user_key'] as String?,
      positionName: json['position_name'] as String?,
      mainSubject: json['main_subject'] as String?,
      subjectId: json['subject_id'] as String?,
      urlImageModel: json['url_image'] == null
          ? null
          : UrlImageModel.fromJson(json['url_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeacherInfoToJson(TeacherInfo instance) =>
    <String, dynamic>{
      'teacher_id': instance.teacherId,
      'user_id': instance.userId,
      'birthday': instance.birthday,
      'school_id': instance.schoolId,
      'school_name': instance.schoolName,
      'full_name': instance.fullName,
      'user_key': instance.userKey,
      'position_name': instance.positionName,
      'main_subject': instance.mainSubject,
      'subject_id': instance.subjectId,
      'url_image': instance.urlImageModel,
    };
