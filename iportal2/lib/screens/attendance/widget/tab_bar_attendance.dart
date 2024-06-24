import 'package:core/core.dart';
import 'package:core/presentation/screens/attendance/tab_bar_view_day.dart';
import 'package:core/presentation/screens/attendance/tab_bar_view_week.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';

class CTabBarAttendance extends StatelessWidget {
  CTabBarAttendance({
    super.key,
    required this.attendanceBloc,
    required this.selectDate,
    this.stateAttendance,
    this.attendanceWeek,
    this.attendanceMonth,
    this.cTabBarViewDay,
    this.cTabBarViewWeek,
    this.cTabBarViewMonth,
  });

  final AttendanceBloc attendanceBloc;
  final List<AttendanceDay>? stateAttendance;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final DateTime selectDate;
  final CTabBarViewDay? cTabBarViewDay;
  final CTabBarViewDays? cTabBarViewWeek;
  final CTabBarViewDays? cTabBarViewMonth;
  final List<String> tabs = ['Theo ngày', 'Theo tuần', 'Theo tháng'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.blackTransparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: TabBar(
                labelColor: AppColors.red,
                unselectedLabelColor: AppColors.gray400,
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                indicator: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: -15, vertical: 8),
                tabs: _buildTabs(),
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              cTabBarViewDay ??
                  CTabBarViewDay(
                    selectDate: selectDate,
                    lessons: stateAttendance,
                  ),
              cTabBarViewWeek ??
                  CTabBarViewDays(
                    attendanceWeek: attendanceWeek,
                    selectDate: selectDate,
                  ),
              cTabBarViewMonth ??
                  CTabBarViewDays(
                    attendanceWeek: attendanceMonth,
                    selectDate: selectDate,
                    isWeek: false,
                  ),
            ],
          ))
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Align(
          child: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
        ),
      );
    }).toList();
  }
}
