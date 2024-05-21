import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/bus_model.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/meta_model.dart';

part 'bus_schedule_model.g.dart';

@JsonSerializable()
class BusScheduleModel {
  @JsonKey(name: 'data')
  final List<BusModel>? listBusSchedule;
  final Links? links;
  final Meta? meta;
  final String? path;
  @JsonKey(name: 'per_page')
  final int? perPage;
  final int? to;
  final int? total;

  BusScheduleModel({
    this.listBusSchedule,
    this.links,
    this.meta,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory BusScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$BusScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusScheduleModelToJson(this);

  @override
  String toString() {
    return 'BusScheduleModel{listBusSchedule: $listBusSchedule, links: $links, meta: $meta, path: $path, perPage: $perPage, to: $to, total: $total}';
  }

  BusScheduleModel copyWith({
    List<BusModel>? listBusSchedule,
    Links? links,
    Meta? meta,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    return BusScheduleModel(
      listBusSchedule: listBusSchedule ?? this.listBusSchedule,
      links: links ?? this.links,
      meta: meta ?? this.meta,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }
}
