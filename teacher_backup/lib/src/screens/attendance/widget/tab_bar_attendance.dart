import 'package:flutter/material.dart';

import 'package:core/resources/resources.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/attendance/widget/tab_bar_view_day.dart';
import 'package:teacher/src/screens/attendance/widget/tab_bar_view_week.dart';
import 'package:teacher/src/screens/home/models/week_data_model.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:teacher/src/screens/schedule/widgets/dropdown_schedule.dart';

List<String> optionList = ['Lớp 6.1', 'Lớp 6.2', 'Lớp 6.3', 'Lớp 6.4'];

class TabBarAttendance extends StatelessWidget {
  TabBarAttendance({super.key});
  final List<String> tabs = ['Theo ngày', 'Theo tuần', 'Theo tháng'];

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.notes.svg(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Tổng kết nghỉ phép',
                      style: AppTextStyles.normal16(
                          color: AppColors.brand600,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: DropdownButtonComponent(
                    color: AppColors.brand600,
                    hint: 'Lớp 6.1',
                    selectedOption: 'Lớp 6.2',
                    onUpdateOption: (value) {},
                    isSelectYear: true,
                    optionList: optionList,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.blackTransparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              labelColor: AppColors.red,
              unselectedLabelColor: AppColors.gray400,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              indicator: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: -15, vertical: 4),
              tabs: _buildTabs(),
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
