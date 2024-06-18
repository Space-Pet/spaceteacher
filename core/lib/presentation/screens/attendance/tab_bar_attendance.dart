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
    required this.selectDate,
    this.attendanceMonth,
    this.cTabBarViewDay,
    this.cTabBarViewWeek,
    this.cTabBarViewMonth,
  });

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
    return Flexible(
        child: DefaultTabController(
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
                onTap: (index) {
                  if (index == 1) {}
                },
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
