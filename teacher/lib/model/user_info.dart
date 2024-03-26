import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String? name;

  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'pupil_id')
  final int? pupilId;
  final int? type;
  @JsonKey(name: 'type_text')
  final String? typeText;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'parent_name')
  final String? parentName;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'class_name')
  final String? className;
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @JsonKey(name: 'school_logo')
  final String? schoolLogo;
  @JsonKey(name: 'school_brand')
  final String? schoolBrand;

  UserInfo(
      {this.name,
      this.userKey,
      this.userId,
      this.schoolId,
      this.pupilId,
      this.type,
      this.typeText,
      this.parentId,
      this.parentName,
      this.learnYear,
      this.className,
      this.schoolName,
      this.schoolLogo,
      this.schoolBrand});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
