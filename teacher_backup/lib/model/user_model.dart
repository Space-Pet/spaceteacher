import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/user_info.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'expires_in')
  final String? expiresIn;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'info')
  final UserInfo? userInfo;

  UserModel({this.accessToken, this.expiresIn, this.tokenType, this.userInfo});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
