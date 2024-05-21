import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/src/screens/home/models/day_list_model.dart';
part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceData {
  final String? day; // hiển thị ngày mấy của tháng nào
  final List<DayList>? dayList;

  AttendanceData({this.day, this.dayList});

  factory AttendanceData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataToJson(this);

  AttendanceData copyWith({
    String? day,
    List<DayList>? dayList,
  }) {
    return AttendanceData(
      day: day ?? this.day,
      dayList: dayList ?? this.dayList,
    );
  }

  @override
  String toString() {
    return 'AttendanceData{day: $day, dayList: $dayList}';
  }
}
