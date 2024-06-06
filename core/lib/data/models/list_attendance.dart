import 'package:json_annotation/json_annotation.dart';

part 'list_attendance.g.dart';

@JsonSerializable()
class ListAttendanceModel {
  @JsonKey(name: 'pupil_id')
  final int pupilId;

  @JsonKey(name: 'pupil_name')
  final String pupilName;

  @JsonKey(name: 'class_id')
  final int classId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'leave_application_data')
  final List<LeaveApplicationData>? leaveApplicationData;

  @JsonKey(name: 'url_image')
  final UrlImageAttendance urlImage;

  ListAttendanceModel({
    required this.pupilId,
    required this.pupilName,
    required this.classId,
    this.status,
    this.date,
    this.leaveApplicationData,
    required this.urlImage,
  });

  factory ListAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$ListAttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListAttendanceModelToJson(this);
}

@JsonSerializable()
class LeaveApplicationData {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'pupil_id')
  final int pupilId;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  LeaveApplicationData({
    required this.id,
    required this.pupilId,
    required this.content,
    required this.startDate,
    required this.endDate,
  });

  factory LeaveApplicationData.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplicationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveApplicationDataToJson(this);
}

@JsonSerializable()
class UrlImageAttendance {
  @JsonKey(name: 'web')
  final String web;

  @JsonKey(name: 'mobile')
  final String mobile;

  UrlImageAttendance({
    required this.web,
    required this.mobile,
  });

  factory UrlImageAttendance.fromJson(Map<String, dynamic> json) =>
      _$UrlImageAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$UrlImageAttendanceToJson(this);
}
