import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';
import 'package:teacher/screens/phone_book/widget/tab_bar_view_phone_book.dart';

class TabBarPhoneBook extends StatelessWidget {
  TabBarPhoneBook({
    super.key,
    this.phoneBookStudent,
    this.phoneBookTeacher,
    required this.currentUserBloc,
    this.onStudentTap,
    this.onParentTap,
  });

  final List<String> tabs = ['Học sinh', 'Cha mẹ học sinh'];
  final List<PhoneBook>? phoneBookStudent;
  final List<PhoneBook>? phoneBookTeacher;
  final CurrentUserBloc currentUserBloc;
  final void Function(PhoneBook)? onStudentTap;
  final void Function(PhoneBook)? onParentTap;

  @override
  Widget build(BuildContext context) {
    final fullName = currentUserBloc.state.user.name;

    final nameParts = fullName.split(' ');

    final lastName = nameParts.last;
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
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
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                color: AppColors.white,
              ),
              child: TabBarView(
                children: [
                  TabBarViewPhoneBook(
                    title: '',
                    phoneBookStudent: phoneBookStudent,
                    onStudentTap: onStudentTap,
                    index: 0,
                  ),
                  TabBarViewPhoneBook(
                    phoneBookTeacher: phoneBookTeacher,
                    title: '',
                    onParentTap: onParentTap,
                    index: 1,
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
