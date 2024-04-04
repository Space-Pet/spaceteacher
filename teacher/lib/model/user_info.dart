import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/children_model.dart';
import 'package:teacher/model/training_level.dart';

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
  @JsonKey(name: 'cap_dao_tao')
  final TrainingLevel? capDaoTao;
  final String? email;
  @JsonKey(name: 'father_name')
  final String? fatherName;

  final int? semester;
  final ChildrenModel? children;
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
      this.schoolBrand,
      this.capDaoTao,
      this.email,
      this.fatherName,
      this.semester,
      this.children});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  bool isKinderGarten() {
    return ['C_001', 'C_002'].contains(capDaoTao?.id);
  }

  UserInfo coppyWith(
      {String? name,
      String? userKey,
      int? userId,
      int? schoolId,
      int? pupilId,
      int? type,
      String? typeText,
      int? parentId,
      String? parentName,
      String? learnYear,
      String? className,
      String? schoolName,
      String? schoolLogo,
      String? schoolBrand,
      TrainingLevel? capDaoTao,
      String? email,
      String? fatherName,
      int? semester,
      ChildrenModel? children}) {
    return UserInfo(
        name: name ?? this.name,
        userKey: userKey ?? this.userKey,
        userId: userId ?? this.userId,
        schoolId: schoolId ?? this.schoolId,
        pupilId: pupilId ?? this.pupilId,
        type: type ?? this.type,
        typeText: typeText ?? this.typeText,
        parentId: parentId ?? this.parentId,
        parentName: parentName ?? this.parentName,
        learnYear: learnYear ?? this.learnYear,
        className: className ?? this.className,
        schoolName: schoolName ?? this.schoolName,
        schoolLogo: schoolLogo ?? this.schoolLogo,
        schoolBrand: schoolBrand ?? this.schoolBrand,
        capDaoTao: capDaoTao ?? this.capDaoTao,
        email: email ?? this.email,
        fatherName: fatherName ?? this.fatherName,
        semester: semester ?? this.semester,
        children: children ?? this.children);
  }
}
