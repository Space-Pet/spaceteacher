// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as String?,
      tokenType: json['token_type'] as String?,
      userInfo: json['info'] == null
          ? null
          : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'token_type': instance.tokenType,
      'info': instance.userInfo,
    };
