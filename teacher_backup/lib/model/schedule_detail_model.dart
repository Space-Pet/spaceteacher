import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/subject_model.dart';
part 'schedule_detail_model.g.dart';

@JsonSerializable()
class ScheduleDetailModel {
  @JsonKey(name: 'Date')
  final String? date;
  @JsonKey(name: 'Date_Name')
  final String? dateName;
  @JsonKey(name: 'DateSubject')
  final List<SubjectModel>? dateSubject;

  ScheduleDetailModel({
    this.date,
    this.dateName,
    this.dateSubject,
  });

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailModelToJson(this);

  @override
  String toString() {
    return 'ScheduleDetailModel{date: $date, dateName: $dateName, dateSubject: $dateSubject}';
  }

  ScheduleDetailModel copyWith({
    String? date,
    String? dateName,
    List<SubjectModel>? dateSubject,
  }) {
    return ScheduleDetailModel(
      date: date ?? this.date,
      dateName: dateName ?? this.dateName,
      dateSubject: dateSubject ?? this.dateSubject,
    );
  }
}
