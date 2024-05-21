// class AttendanceModel {
//   final List<MonthData> months;

//   AttendanceModel({required this.months});
// }

// class MonthData {
//   final int totalMonthLessons; // số tiết học của tháng
//   final int totalMonthAbsent; // số tiết vắng cuả tháng
//   final int totalMonthPresent; // số tiết có mặt của tháng
//   final String month; // tháng mấy
//   final List<WeekData> weeks;

//   MonthData(
//       {required this.totalMonthLessons,
//       required this.weeks,
//       required this.month,
//       required this.totalMonthAbsent,
//       required this.totalMonthPresent});
// }

class WeekData {
  final int totalWeekLessons; // số tiết học của tuần
  final int totalWeekAbsent; // số tiết vắng của tuần
  final int totalWeekPresent; // số tiết có mặt cuả tuần
  final String data; // hiển thị tuần thứ mấy từ ngày nào đến ngày nào

  final List<AttendanceData> attendanceList;

  WeekData(
      {required this.totalWeekLessons,
      required this.attendanceList,
      required this.totalWeekAbsent,
      required this.data,
      required this.totalWeekPresent});
}

class AttendanceData {
  final String day; // hiển thị ngày mấy của tháng nào
  final List<DayList> dayList;

  AttendanceData({required this.day, required this.dayList});
}

class DayList {
  final String description; // môn học vắng
  final String isAbsent; // vắng có phép hoặc không phép

  DayList({required this.description, required this.isAbsent});
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
