import 'package:json_annotation/json_annotation.dart';
part 'bus_route_model.g.dart';

@JsonSerializable()
class BusRoutesModel {
  final int? id;
  final String? name;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'route_from')
  final String? routeFrom;
  @JsonKey(name: 'route_to')
  final String? routeTo;
  @JsonKey(name: 'route_length_text')
  final String? routeLengthText;
  @JsonKey(name: 'route_type')
  final int? routeType;
  @JsonKey(name: 'route_type_text')
  final String? routeTypeText;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  final int? status;

  BusRoutesModel({
    this.id,
    this.name,
    this.schoolId,
    this.routeFrom,
    this.routeTo,
    this.routeLengthText,
    this.routeType,
    this.routeTypeText,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory BusRoutesModel.fromJson(Map<String, dynamic> json) =>
      _$BusRoutesModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusRoutesModelToJson(this);

  @override
  String toString() {
    return 'BusRoutesModel{id: $id, name: $name, schoolId: $schoolId, routeFrom: $routeFrom, routeTo: $routeTo, routeLengthText: $routeLengthText, routeType: $routeType, routeTypeText: $routeTypeText, startDate: $startDate, endDate: $endDate, status: $status}';
  }

  BusRoutesModel copyWith({
    int? id,
    String? name,
    int? schoolId,
    String? routeFrom,
    String? routeTo,
    String? routeLengthText,
    int? routeType,
    String? routeTypeText,
    String? startDate,
    String? endDate,
    int? status,
  }) {
    return BusRoutesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      schoolId: schoolId ?? this.schoolId,
      routeFrom: routeFrom ?? this.routeFrom,
      routeTo: routeTo ?? this.routeTo,
      routeLengthText: routeLengthText ?? this.routeLengthText,
      routeType: routeType ?? this.routeType,
      routeTypeText: routeTypeText ?? this.routeTypeText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
