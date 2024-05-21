import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/item_list_schedule_model.dart';
part 'list_schedule_model.g.dart';

@JsonSerializable()
class ListScheduleModel {
  @JsonKey(name: 'trang_thai')
  final bool? status;
  @JsonKey(name: 'noi_dung_trang_thai')
  final String? contentStatus;
  @JsonKey(name: 'data')
  final List<ItemListScheduleModel>? data;

  ListScheduleModel({this.status, this.contentStatus, this.data});

  factory ListScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ListScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListScheduleModelToJson(this);

  @override
  String toString() {
    return 'ListScheduleModel{status: $status, contentStatus: $contentStatus, data: $data}';
  }

  ListScheduleModel copyWith({
    bool? status,
    String? contentStatus,
    List<ItemListScheduleModel>? data,
  }) {
    return ListScheduleModel(
      status: status ?? this.status,
      contentStatus: contentStatus ?? this.contentStatus,
      data: data ?? this.data,
    );
  }
}
