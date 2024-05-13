import 'package:core/data/models/models.dart';
import 'package:core/presentation/screens/attendance/tab_bar_attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_day.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_week.dart';

import '../bloc/attendance_bloc.dart';

class TabBarAttendance extends StatelessWidget {
  TabBarAttendance(
      {super.key,
      this.stateAttendance,
      this.attendanceWeek,
      this.selectDate,
      this.attendanceMonth});
  final List<AttendanceDay>? stateAttendance;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final DateTime? selectDate;
  final List<String> tabs = ['Theo ngày', 'Theo tuần', 'Theo tháng'];
  @override
  Widget build(BuildContext context) {
    return CTabBarAttendance(
      stateAttendance: stateAttendance,
      attendanceWeek: attendanceWeek,
      attendanceMonth: attendanceMonth,
      selectDate: selectDate,
      cTabBarViewDay: TabBarViewDay(
        selectDate: selectDate,
        lessons: stateAttendance,
        getAttendanceDay: (formattedDate, date) {
          context.read<AttendanceBloc>().add(
                GetAttendanceDay(
                  date: formattedDate,
                  selectDate: date,
                ),
              );
        },
      ),
      cTabBarViewWeek: TabBarViewWeek(
        attendanceWeek: attendanceWeek,
        getAttendanceWeek: (endDate, startDate) {
          context.read<AttendanceBloc>().add(
                GetAttendanceWeek(
                  endDate: endDate,
                  startDate: startDate,
                ),
              );
        },
      ),
      cTabBarViewMonth: TabBarViewWeek(
        attendanceWeek: attendanceMonth,
        isWeek: false,
        getAttendanceMonth: (endDate, startDate) {
          context.read<AttendanceBloc>().add(
                GetAttendanceMonth(
                  endDate: endDate,
                  startDate: startDate,
                ),
              );
        },
      ),
    );
  }
}
