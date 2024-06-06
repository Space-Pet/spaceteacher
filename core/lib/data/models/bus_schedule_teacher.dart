import 'package:json_annotation/json_annotation.dart';

import 'detail_bus_schedule.dart';

part 'bus_schedule_teacher.g.dart';

@JsonSerializable()
class BusScheduleTeacher {
  final int? id;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'departure_time')
  final String? departureTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'cancel_at')
  final String? cancelAt;
  @JsonKey(name: 'route_id')
  final int? routeId;
  @JsonKey(name: 'bus_id')
  final int? busId;
  @JsonKey(name: 'teacher_id')
  final int? teacherId;
  @JsonKey(name: 'teacher_phone')
  final String? teacherPhone;
  @JsonKey(name: 'sub_driver')
  final String? subDriver;
  @JsonKey(name: 'schedule_type')
  final String? scheduleType;
  @JsonKey(name: 'route_name')
  final String? routeName;
  @JsonKey(name: 'number_plate')
  final String? numberPlate;
  @JsonKey(name: 'driver_name')
  final String? driverName;
  final Teacher? teacher;
  @JsonKey(name: 'total_pupil')
  final int? totalPupil;
  final Absence? absence;

  BusScheduleTeacher({
    required this.id,
    required this.schoolId,
    required this.departureTime,
    required this.endTime,
    this.cancelAt,
    required this.routeId,
    required this.busId,
    required this.teacherId,
    required this.teacherPhone,
    required this.subDriver,
    required this.scheduleType,
    required this.routeName,
    required this.numberPlate,
    this.driverName,
    this.teacher,
    this.totalPupil,
    this.absence,
  });

  factory BusScheduleTeacher.fromJson(Map<String, dynamic> json) =>
      _$BusScheduleTeacherFromJson(json);

  Map<String, dynamic> toJson() => _$BusScheduleTeacherToJson(this);
}

@JsonSerializable()
class Teacher {
  final int? id;
  @JsonKey(name: 'teacher_name')
  final String? teacherName;
  @JsonKey(name: 'mobile_phone')
  final String? mobilePhone;
  final ImageBus? image;

  Teacher({
    this.id,
    this.teacherName,
    this.mobilePhone,
    this.image,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}

@JsonSerializable()
class ImageBus {
  final String? web;
  final String? mobile;

  ImageBus({
    this.web,
    this.mobile,
  });

  factory ImageBus.fromJson(Map<String, dynamic> json) =>
      _$ImageBusFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBusToJson(this);
}
