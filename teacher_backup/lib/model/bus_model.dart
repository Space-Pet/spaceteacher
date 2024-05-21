import 'package:json_annotation/json_annotation.dart';

part 'bus_model.g.dart';

@JsonSerializable()
class BusModel {
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

  BusModel({
    this.id,
    this.schoolId,
    this.departureTime,
    this.endTime,
    this.cancelAt,
    this.routeId,
    this.busId,
    this.teacherId,
    this.teacherPhone,
    this.subDriver,
    this.scheduleType,
    this.routeName,
    this.numberPlate,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) =>
      _$BusModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusModelToJson(this);

  @override
  String toString() {
    return 'BusModel{id: $id, schoolId: $schoolId, departureTime: $departureTime, endTime: $endTime, cancelAt: $cancelAt, routeId: $routeId, busId: $busId, teacherId: $teacherId, teacherPhone: $teacherPhone, subDriver: $subDriver, scheduleType: $scheduleType, routeName: $routeName, numberPlate: $numberPlate}';
  }

  BusModel copyWith({
    int? id,
    int? schoolId,
    String? departureTime,
    String? endTime,
    String? cancelAt,
    int? routeId,
    int? busId,
    int? teacherId,
    String? teacherPhone,
    String? subDriver,
    String? scheduleType,
    String? routeName,
    String? numberPlate,
  }) {
    return BusModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      departureTime: departureTime ?? this.departureTime,
      endTime: endTime ?? this.endTime,
      cancelAt: cancelAt ?? this.cancelAt,
      routeId: routeId ?? this.routeId,
      busId: busId ?? this.busId,
      teacherId: teacherId ?? this.teacherId,
      teacherPhone: teacherPhone ?? this.teacherPhone,
      subDriver: subDriver ?? this.subDriver,
      scheduleType: scheduleType ?? this.scheduleType,
      routeName: routeName ?? this.routeName,
      numberPlate: numberPlate ?? this.numberPlate,
    );
  }
}
