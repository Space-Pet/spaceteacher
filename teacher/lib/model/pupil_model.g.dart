// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilModel _$PupilModelFromJson(Map<String, dynamic> json) => PupilModel(
      pupilID: (json['pupil_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      userID: json['user_id'] as String?,
      userKey: json['user_key'] as String?,
      learnYear: json['learn_year'] as String?,
      customerID: (json['customer_id'] as num?)?.toInt(),
      birthday: json['birthday'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      status: (json['status'] as num?)?.toInt(),
      statusText: json['status_text'] as String?,
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$PupilModelToJson(PupilModel instance) =>
    <String, dynamic>{
      'pupil_id': instance.pupilID,
      'name': instance.name,
      'user_id': instance.userID,
      'user_key': instance.userKey,
      'learn_year': instance.learnYear,
      'customer_id': instance.customerID,
      'birthday': instance.birthday,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'status': instance.status,
      'status_text': instance.statusText,
      'identifier': instance.identifier,
    };
