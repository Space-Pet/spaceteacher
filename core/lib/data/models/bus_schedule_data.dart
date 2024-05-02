// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule_data.freezed.dart';
part 'bus_schedule_data.g.dart';

@freezed
class BusScheduleData with _$BusScheduleData {
  const factory BusScheduleData({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'school_id') required int schoolId,
    @JsonKey(name: 'schedule_id') required int scheduleId,
    @JsonKey(name: 'attendance_date') required String attendanceDate,
    @JsonKey(name: 'attendance') required int attendance,
    @JsonKey(name: 'check_out') required String? checkOut,
    @JsonKey(name: 'check_in') required String? checkIn,
    @JsonKey(name: 'pupil') required PupilData pupil,
    @JsonKey(name: 'route') required RouteData route,
    @JsonKey(name: 'attendance_fee_type')
    required AttendanceFeeTypeData attendanceFeeType,
    @JsonKey(name: 'schedule_type') required ScheduleTypeData scheduleType,
    @JsonKey(name: 'bus_stop') required BusStopData busStop,
    @JsonKey(name: 'driver_info') required DriverInfoData driverInfo,
    @JsonKey(name: 'teacher') required TeacherData teacher,
  }) = _BusScheduleData;
  factory BusScheduleData.fromJson(Map<String, Object?> json) =>
      _$BusScheduleDataFromJson(json);
}

@freezed
class PupilData with _$PupilData {
  const factory PupilData({
    @JsonKey(name: 'pupil_id') required int pupilId,
    @JsonKey(name: 'pupil_name') required String pupilName,
  }) = _PupilData;

  factory PupilData.fromJson(Map<String, Object?> json) =>
      _$PupilDataFromJson(json);
}

@freezed
class RouteData with _$RouteData {
  const factory RouteData({
    @JsonKey(name: 'route_id') required int routeId,
    @JsonKey(name: 'route_name') required String routeName,
  }) = _RouteData;

  factory RouteData.fromJson(Map<String, Object?> json) =>
      _$RouteDataFromJson(json);
}

@freezed
class AttendanceFeeTypeData with _$AttendanceFeeTypeData {
  const factory AttendanceFeeTypeData({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'text') required String text,
  }) = _AttendanceFeeTypeData;

  factory AttendanceFeeTypeData.fromJson(Map<String, Object?> json) =>
      _$AttendanceFeeTypeDataFromJson(json);
}

@freezed
class ScheduleTypeData with _$ScheduleTypeData {
  const factory ScheduleTypeData({
    @JsonKey(name: 'value') required int value,
    @JsonKey(name: 'text') required String text,
  }) = _ScheduleTypeData;

  factory ScheduleTypeData.fromJson(Map<String, Object?> json) =>
      _$ScheduleTypeDataFromJson(json);
}

@freezed
class BusStopData with _$BusStopData {
  const factory BusStopData({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'estimate_time') required String estimatedTime,
  }) = _BusStopData;

  factory BusStopData.fromJson(Map<String, Object?> json) =>
      _$BusStopDataFromJson(json);
}

@freezed
class DriverInfoData with _$DriverInfoData {
  const factory DriverInfoData({
    @JsonKey(name: 'bus_id') required int busId,
    @JsonKey(name: 'sub_driver') required String subDriver,
    @JsonKey(name: 'number_plate') required String numberPlate,
    @JsonKey(name: 'driver_name') required String driverName,
  }) = _DriverInfoData;

  factory DriverInfoData.fromJson(Map<String, Object?> json) =>
      _$DriverInfoDataFromJson(json);
}

@freezed
class TeacherData with _$TeacherData {
  const factory TeacherData({
    @JsonKey(name: 'teacher_id') required int teacherId,
    @JsonKey(name: 'teacher_name') required String teacherName,
    @JsonKey(name: 'mobile_phone') required String mobilePhone,
    @JsonKey(name: 'image') required ImageData image,
  }) = _TeacherData;

  factory TeacherData.fromJson(Map<String, Object?> json) =>
      _$TeacherDataFromJson(json);
}

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    @JsonKey(name: 'web') required String web,
    @JsonKey(name: 'mobile') required String mobile,
  }) = _ImageData;

  factory ImageData.fromJson(Map<String, Object?> json) =>
      _$ImageDataFromJson(json);
}
