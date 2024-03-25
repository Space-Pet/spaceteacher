import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class RequestOtpResult {
  String? id;

  RequestOtpResult(this.id);

  factory RequestOtpResult.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpResultFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpResultToJson(this);
}

@JsonSerializable()
class LoginResult {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  @JsonKey(name: 'expires_in')
  int? expireIn;

  LoginResult(
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expireIn,
  );

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
