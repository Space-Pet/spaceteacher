import 'package:json_annotation/json_annotation.dart';

part 'detail_bus_schedule.g.dart';

@JsonSerializable()
class DetailBusSchedule {
  final int? id;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'departure_time')
  final String? departureTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'schedule_type')
  final String? scheduleType;
  @JsonKey(name: 'driver_info')
  final DriverInfo? driverInfo;
  final RouteBus? route;
  final TeacherDetailBus? teacher;
  final int? total;
  final Absence? absence;

  DetailBusSchedule({
    this.id,
    this.schoolId,
    this.departureTime,
    this.endTime,
    this.scheduleType,
    this.driverInfo,
    this.route,
    this.teacher,
    this.total,
    this.absence,
  });

  factory DetailBusSchedule.fromJson(Map<String, dynamic> json) =>
      _$DetailBusScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DetailBusScheduleToJson(this);
}

@JsonSerializable()
class DriverInfo {
  @JsonKey(name: 'bus_id')
  final int? busId;
  @JsonKey(name: 'sub_driver')
  final String? subDriver;
  @JsonKey(name: 'number_plate')
  final String? numberPlate;
  @JsonKey(name: 'driver_name')
  final String? driverName;

  DriverInfo({
    this.busId,
    this.subDriver,
    this.numberPlate,
    this.driverName,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverInfoToJson(this);
}

@JsonSerializable()
class RouteBus {
  final int? id;
  final String? name;

  RouteBus({
    this.id,
    this.name,
  });

  factory RouteBus.fromJson(Map<String, dynamic> json) =>
      _$RouteBusFromJson(json);

  Map<String, dynamic> toJson() => _$RouteBusToJson(this);
}

@JsonSerializable()
class Absence {
  final int? count;
  final List<Pupil>? pupils;

  Absence({
    this.count,
    this.pupils,
  });

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);

  Map<String, dynamic> toJson() => _$AbsenceToJson(this);
}

@JsonSerializable()
class Pupil {
  final int? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final ImageBusDetail? avatar;
  @JsonKey(name: 'leave_application')
  final int? leaveApplication;

  Pupil({
    this.id,
    this.fullName,
    this.avatar,
    this.leaveApplication
  });

  factory Pupil.fromJson(Map<String, dynamic> json) =>
      _$PupilFromJson(json);

  Map<String, dynamic> toJson() => _$PupilToJson(this);
}

@JsonSerializable()
class ImageBusDetail {
  final String? web;
  final String? mobile;

  ImageBusDetail({
    this.web,
    this.mobile,
  });

  factory ImageBusDetail.fromJson(Map<String, dynamic> json) =>
      _$ImageBusDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBusDetailToJson(this);
}

@JsonSerializable()
class TeacherDetailBus {
  final int? id;
  @JsonKey(name: 'teacher_name')
  final String? teacherName;
  @JsonKey(name: 'mobile_phone')
  final String? mobilePhone;
  final ImageBusDetail? image;

  TeacherDetailBus({
    this.id,
    this.teacherName,
    this.mobilePhone,
    this.image,
  });

  factory TeacherDetailBus.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailBusFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherDetailBusToJson(this);
}
