import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/schedule_detail_model.dart';
part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  @JsonKey(name: 'tkb_date_apply')
  final String? tkbDateApply;
  @JsonKey(name: 'tkb_class')
  final String? tkbClass;
  @JsonKey(name: 'tkb_data')
  final List<ScheduleDetailModel>? tkbData;

  ScheduleModel({
    this.tkbDateApply,
    this.tkbClass,
    this.tkbData,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  @override
  String toString() {
    return 'ScheduleModel{tkbDateApply: $tkbDateApply, tkbClass: $tkbClass, tkbData: $tkbData}';
  }

  ScheduleModel copyWith({
    String? tkbDateApply,
    String? tkbClass,
    List<ScheduleDetailModel>? tkbData,
  }) {
    return ScheduleModel(
      tkbDateApply: tkbDateApply ?? this.tkbDateApply,
      tkbClass: tkbClass ?? this.tkbClass,
      tkbData: tkbData ?? this.tkbData,
    );
  }
}
