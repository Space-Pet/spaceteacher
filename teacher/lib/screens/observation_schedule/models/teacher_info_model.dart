import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/screens/observation_schedule/models/url_image_model.dart';

part 'teacher_info_model.g.dart';

@JsonSerializable()
class TeacherInfo {
  @JsonKey(name: 'teacher_id')
  final int? teacherId;
  @JsonKey(name: 'user_id')
  final String? userId;

  final String? birthday;

  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'position_name')
  final String? positionName;
  @JsonKey(name: 'main_subject')
  final String? mainSubject;
  @JsonKey(name: 'subject_id')
  final String? subjectId;
  @JsonKey(name: 'url_image')
  final UrlImageModel? urlImageModel;

  factory TeacherInfo.fromJson(Map<String, dynamic> json) =>
      _$TeacherInfoFromJson(json);

  TeacherInfo(
      {this.teacherId,
      this.userId,
      this.birthday,
      this.schoolId,
      this.schoolName,
      this.fullName,
      this.userKey,
      this.positionName,
      this.mainSubject,
      this.subjectId,
      this.urlImageModel});

  Map<String, dynamic> toJson() => _$TeacherInfoToJson(this);
}
