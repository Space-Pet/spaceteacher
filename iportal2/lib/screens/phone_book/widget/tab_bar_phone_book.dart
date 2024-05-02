import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/phone_book/widget/tab_bar_view_phone_book.dart';

import '../../../resources/app_colors.dart';

class TabBarPhoneBook extends StatelessWidget {
  TabBarPhoneBook({
    super.key,
    this.phoneBookStudent,
    this.phoneBookTeacher,
    required this.currentUserBloc,
  });

  final List<String> tabs = ['Danh bạ học sinh', 'Danh bạ giáo viên'];
  final List<PhoneBookStudent>? phoneBookStudent;
  final List<PhoneBookTeacher>? phoneBookTeacher;
  final CurrentUserBloc currentUserBloc;

  @override
  Widget build(BuildContext context) {
    final fullName = currentUserBloc.state.user.name;

    final nameParts = fullName.split(' ');

    final lastName = nameParts.last;
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                  tabs: _buildTabs(),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                TabBarViewPhoneBook(
                  title: 'Bạn cùng lớp của $lastName',
                  phoneBookStudent: phoneBookStudent,
                ),
                TabBarViewPhoneBook(
                  phoneBookTeacher: phoneBookTeacher,
                  title: 'Giáo viên đang dạy $lastName',
                )
              ],
            ),
          )
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
