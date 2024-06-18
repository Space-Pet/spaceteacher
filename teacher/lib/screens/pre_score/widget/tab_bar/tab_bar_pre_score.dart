import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/tab_bar/tab_bar_view_comment.dart';
import 'package:teacher/screens/pre_score/widget/tab_bar/tav_bar_view_report.dart';

class TabBarPreScore extends StatelessWidget {
  TabBarPreScore({
    super.key,
    required this.phoneBookStudent,
  });
  final PhoneBookStudent phoneBookStudent;
  final List<String> tabs = ['Nhận xét', 'Báo cáo học tập'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: tabs.length,
        child: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.blackTransparent,
                    borderRadius: BorderRadius.circular(40),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      indicator: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                          ),
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: -15),
                      tabs: _buildTabs(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TabBarViewComment(
                      phoneBookStudent: phoneBookStudent,
                    ),
                    // TabBarViewReport(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            ),
          ),
        ),
      );
    }).toList();
  }
}
