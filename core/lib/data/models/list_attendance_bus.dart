import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_attendance_bus.g.dart';

@JsonSerializable()
class ListAttendanceBus {
  final int id;
  final String name;
  final String address;
  final String time;
  final List<Pupils>? pupils;

  ListAttendanceBus({
    required this.address,
    required this.id,
    required this.name,
    required this.time,
    this.pupils,
  });
  factory ListAttendanceBus.fromJson(Map<String, dynamic> json) =>
      _$ListAttendanceBusFromJson(json);
  Map<String, dynamic> toJson() => _$ListAttendanceBusToJson(this);
}

@JsonSerializable()
class Pupils {
  final int id;
  @JsonKey(name: 'school_id')
  final int schoolId;
  @JsonKey(name: 'schedule_id')
  final int scheduleId;
  @JsonKey(name: 'route_id')
  final int routeId;
  @JsonKey(name: 'route_name')
  final String routeName;
  @JsonKey(name: 'bus_stop_id')
  final int busStopId;
  @JsonKey(name: 'pupil_id')
  final int pupliId;
  @JsonKey(name: 'attendance_date')
  final String attendanceDate;
  late int? attendance;
  @JsonKey(name: 'attendance_type')
  final int attendancetype;
  @JsonKey(name: 'attendance_fee_type_text')
  final String attendanceFeeTypeText;
  @JsonKey(name: 'check_in')
  final String? checkIn;
  @JsonKey(name: 'check_out')
  final String? checkOut;
  @JsonKey(name: 'bus_stop_name')
  final String busStopName;
  @JsonKey(name: 'bus_stop_address')
  final String busStopAddress;
  @JsonKey(name: 'time_estimate')
  final String timeEstimate;
  @JsonKey(name: 'pupil_name')
  final String pupilName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'leave_application')
  late int? leaveApplication;
  final Thumbnail thumbnail;
  Pupils(
      {required this.thumbnail,
      this.attendance,
      required this.routeId,
      required this.routeName,
      this.checkIn,
      this.checkOut,
      required this.attendanceDate,
      required this.attendanceFeeTypeText,
      required this.attendancetype,
      required this.busStopAddress,
      required this.busStopId,
      required this.busStopName,
      this.leaveApplication,
      required this.id,
      required this.phoneNumber,
      required this.pupilName,
      required this.pupliId,
      required this.scheduleId,
      required this.schoolId,
      required this.timeEstimate});

  factory Pupils.fromJson(Map<String, dynamic> json) => _$PupilsFromJson(json);
  Map<String, dynamic> toJson() => _$PupilsToJson(this);
}

@JsonSerializable()
class Thumbnail {
  @JsonKey(name: 'web')
  final String web;

  @JsonKey(name: 'mobile')
  final String mobile;

  Thumbnail({
    required this.web,
    required this.mobile,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
