import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/lesson_data_model.dart';
part 'weekly_lesson_data_model.g.dart';

@JsonSerializable()
class WeeklyLessonDataModel {
  @JsonKey(name: 'Ngay')
  final NgayModel? ngay;
  @JsonKey(name: 'Data')
  final LessonDataModel? data;

  WeeklyLessonDataModel({
    this.ngay,
    this.data,
  });

  factory WeeklyLessonDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyLessonDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyLessonDataModelToJson(this);

  @override
  String toString() {
    return 'WeeklyLessonDataModel{ngay: $ngay, data: $data}';
  }

  WeeklyLessonDataModel copyWith({
    NgayModel? ngay,
    LessonDataModel? data,
  }) {
    return WeeklyLessonDataModel(
      ngay: ngay ?? this.ngay,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class NgayModel {
  @JsonKey(name: 'Date')
  final int? date;
  @JsonKey(name: 'Day')
  final String? day;

  NgayModel({
    this.date,
    this.day,
  });

  factory NgayModel.fromJson(Map<String, dynamic> json) =>
      _$NgayModelFromJson(json);

  Map<String, dynamic> toJson() => _$NgayModelToJson(this);

  @override
  String toString() {
    return 'NgayModel{date: $date, day: $day}';
  }

  NgayModel copyWith({
    int? date,
    String? day,
  }) {
    return NgayModel(
      date: date ?? this.date,
      day: day ?? this.day,
    );
  }
}
