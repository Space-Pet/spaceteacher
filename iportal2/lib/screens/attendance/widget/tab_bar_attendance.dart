import 'package:flutter/material.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_day.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_week.dart';
import 'package:iportal2/screens/home/models/attendance_model.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:iportal2/resources/app_colors.dart';

class TabBarAttendance extends StatelessWidget {
  TabBarAttendance();
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
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  indicator: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
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
              TabBarViewDay(
                lessons: lessons,
              ),
              TabBarViewWeek(
                weekData: weekData,
              ),
              TabBarViewWeek(
                weekData: monthData,
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
          alignment: Alignment.center,
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
