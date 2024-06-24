import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/comment/widget/tab_bar/tab_bar_view_comment.dart';
import 'package:iportal2/screens/comment/widget/tab_bar/tav_bar_view_report.dart';

class TabBarComment extends StatelessWidget {
  TabBarComment({
    super.key,
    required this.comment,
    this.endDate,
    this.startDate,
  });
  final List<String> tabs = ['Nhận xét', 'Báo cáo học tập'];
  final List<Comment> comment;
  final DateTime? endDate;
  final DateTime? startDate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
            height: 54,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.blackTransparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TabBar(
                labelColor: AppColors.brand500,
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
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                tabs: _buildTabs(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                comment.isNotEmpty
                    ? TabBarViewComment(
                        comment: comment.first,
                        endDate: endDate,
                        startDate: startDate,
                      )
                    : const Center(
                        child: EmptyScreen(text: 'Bạn chưa có nhận xét'),
                      ),
                const TabBarViewReport()
              ],
            ),
          ),
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
            ),
          ),
        ),
      );
    }).toList();
  }
}
