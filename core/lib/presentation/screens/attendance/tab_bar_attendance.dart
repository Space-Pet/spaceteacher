import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../../resources/resources.dart';
import 'tab_bar_view_day.dart';
import 'tab_bar_view_week.dart';

class CTabBarAttendance extends StatelessWidget {
  CTabBarAttendance({
    super.key,
    this.stateAttendance,
    this.attendanceWeek,
    this.selectDate,
    this.attendanceMonth,
    this.cTabBarViewDay,
    this.cTabBarViewWeek,
    this.cTabBarViewMonth,
  });
  final List<AttendanceDay>? stateAttendance;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final DateTime? selectDate;
  final CTabBarViewDay? cTabBarViewDay;
  final CTabBarViewWeek? cTabBarViewWeek;
  final CTabBarViewWeek? cTabBarViewMonth;
  final List<String> tabs = ['Theo ngày', 'Theo tuần', 'Theo tháng'];
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.blackTransparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TabBar(
                  labelColor: AppColors.red,
                  unselectedLabelColor: AppColors.gray400,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
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
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                  tabs: _buildTabs(),
                ),
              ),
            ),
          ),
          Flexible(
              child: TabBarView(
            children: [
              cTabBarViewDay ??
                  CTabBarViewDay(
                    selectDate: selectDate,
                    lessons: stateAttendance,
                  ),
              cTabBarViewWeek ??
                  CTabBarViewWeek(
                    attendanceWeek: attendanceWeek,
                  ),
              cTabBarViewMonth ??
                  CTabBarViewWeek(
                    attendanceWeek: attendanceMonth,
                    isWeek: false,
                  ),
            ],
          ))
        ],
      ),
    ));
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
