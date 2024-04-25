import 'package:json_annotation/json_annotation.dart';
part 'item_list_schedule_model.g.dart';

@JsonSerializable()
class ItemListScheduleModel {
  final String? date;
  final bool? current;

  ItemListScheduleModel({this.date, this.current});

  factory ItemListScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ItemListScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListScheduleModelToJson(this);

  @override
  String toString() {
    return 'ItemListScheduleModel{date: $date, current: $current}';
  }

  ItemListScheduleModel copyWith({
    String? date,
    bool? current,
  }) {
    return ItemListScheduleModel(
      date: date ?? this.date,
      current: current ?? this.current,
    );
  }
}
