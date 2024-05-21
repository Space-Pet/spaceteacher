import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/src/screens/home/models/attendance_model.dart';
import 'package:teacher/src/screens/home/models/day_list_model.dart';
part 'week_data_model.g.dart';

@JsonSerializable()
class WeekData {
  final int? totalWeekLessons; // số tiết học của tuần
  final int? totalWeekAbsent; // số tiết vắng của tuần
  final int? totalWeekPresent; // số tiết có mặt cuả tuần
  final String? data; // hiển thị tuần thứ mấy từ ngày nào đến ngày nào

  final List<AttendanceData>? attendanceList;

  WeekData(
      {this.totalWeekLessons,
      this.attendanceList,
      this.totalWeekAbsent,
      this.data,
      this.totalWeekPresent});

  factory WeekData.fromJson(Map<String, dynamic> json) =>
      _$WeekDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeekDataToJson(this);

  WeekData copyWith({
    int? totalWeekLessons,
    List<AttendanceData>? attendanceList,
    int? totalWeekAbsent,
    String? data,
    int? totalWeekPresent,
  }) {
    return WeekData(
      totalWeekLessons: totalWeekLessons ?? this.totalWeekLessons,
      attendanceList: attendanceList ?? this.attendanceList,
      totalWeekAbsent: totalWeekAbsent ?? this.totalWeekAbsent,
      data: data ?? this.data,
      totalWeekPresent: totalWeekPresent ?? this.totalWeekPresent,
    );
  }

  @override
  String toString() {
    return 'WeekData{totalWeekLessons: $totalWeekLessons, totalWeekAbsent: $totalWeekAbsent, totalWeekPresent: $totalWeekPresent, data: $data, attendanceList: $attendanceList}';
  }
}

final List<WeekData> weekData = [
  WeekData(
      totalWeekLessons: 23,
      attendanceList: [
        AttendanceData(day: '01 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
        AttendanceData(day: '03 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tuần 1 (01/01 - 07/01)',
      totalWeekPresent: 21),
  WeekData(
      totalWeekLessons: 20,
      attendanceList: [
        AttendanceData(day: '08 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
        AttendanceData(day: ' th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tuần 2 (08/01 - 14/01)',
      totalWeekPresent: 18),
  WeekData(
      totalWeekLessons: 24,
      attendanceList: [
        AttendanceData(day: '08 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
        AttendanceData(day: '10 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tuần 3 (15/01 - 22/01)',
      totalWeekPresent: 22),
];

final List<WeekData> monthData = [
  WeekData(
      totalWeekLessons: 23,
      attendanceList: [
        AttendanceData(day: '01 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
        AttendanceData(day: '03 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tháng 1',
      totalWeekPresent: 21),
  WeekData(
      totalWeekLessons: 20,
      attendanceList: [
        AttendanceData(day: '08 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
          DayList(description: 'Toán', isAbsent: 'Vắng không phép')
        ]),
        AttendanceData(day: ' th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tháng 2',
      totalWeekPresent: 18),
  WeekData(
      totalWeekLessons: 24,
      attendanceList: [
        AttendanceData(day: '08 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
        AttendanceData(day: '10 th 01', dayList: [
          DayList(description: 'Ngữ văn', isAbsent: 'Vắng có phép'),
        ]),
      ],
      totalWeekAbsent: 2,
      data: 'Tháng 3',
      totalWeekPresent: 22),
];
