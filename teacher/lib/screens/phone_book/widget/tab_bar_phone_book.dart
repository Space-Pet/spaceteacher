import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';
import 'package:teacher/screens/phone_book/widget/tab_bar_view_phone_book.dart';

class TabBarPhoneBook extends StatelessWidget {
  TabBarPhoneBook({
    super.key,
    this.phoneBookStudent,
    this.phoneBookParent,
    this.phoneBookTeacher,
    this.onStudentTap,
    this.onParentTap,
    required this.searchKeyword,
  });

  final List<String> tabs = ['Học sinh', 'Cha mẹ học sinh', 'Giáo viên'];
  final List<PhoneBookStudent>? phoneBookStudent;
  final List<Parent>? phoneBookParent;
  final List<PhoneBookTeacher>? phoneBookTeacher;
  final void Function(PhoneBookStudent studentInfo)? onStudentTap;
  final void Function(PhoneBook)? onParentTap;
  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            labelPadding: const EdgeInsets.only(left: 20, right: 20),
            labelColor: AppColors.brand600,
            unselectedLabelColor: AppColors.brand600,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            tabs: _buildTabs(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              decoration: const BoxDecoration(color: AppColors.white),
              child: TabBarView(
                children: [
                  TabBarViewPhoneBook(
                    phoneBookStudent: phoneBookStudent,
                    onStudentTap: onStudentTap,
                    index: 0,
                    searchKeyword: searchKeyword,
                  ),
                  TabBarViewPhoneBook(
                    phoneBookParent: phoneBookParent,
                    onParentTap: onParentTap,
                    searchKeyword: searchKeyword,
                    index: 1,
                  ),
                  TabBarViewPhoneBook(
                    phoneBookTeacher: phoneBookTeacher,
                    searchKeyword: searchKeyword,
                    onParentTap: onParentTap,
                    index: 2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }
}
