import 'package:flutter/material.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_day.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_week.dart';
import 'package:iportal2/screens/home/models/attendance_model.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:network_data_source/network_data_source.dart';

class TabBarAttendance extends StatelessWidget {
  TabBarAttendance(
      {super.key,
      this.stateAttendance,
      this.attendanceWeek,
      this.attendanceMonth});
  final List<AttendanceDay>? stateAttendance;
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
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
                  onTap: (index) {
                    // if (index == 1) {
                    //   context.read<AttendanceBloc>().add(GetAttendanceWeek(
                    //       endDate: '2024-03-28', startDate: '2024-01-01'));
                    // }
                  },
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
          if (stateAttendance == [] || stateAttendance == null)
            Flexible(
                child: TabBarView(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )),
          if (stateAttendance != [] || stateAttendance != null)
            Flexible(
                child: TabBarView(
              children: [
                TabBarViewDay(
                  lessons: stateAttendance,
                ),
                TabBarViewWeek(
                  attendanceWeek: attendanceWeek,
                ),
                TabBarViewWeek(
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
