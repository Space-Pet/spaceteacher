import 'package:flutter/material.dart';
import 'package:iportal2/screens/phone_book/model/list_phone_book.dart';
import 'package:iportal2/screens/phone_book/widget/tab_bar_view_phone_book.dart';

import '../../../resources/app_colors.dart';

class TabBarPhoneBook extends StatelessWidget {
  TabBarPhoneBook({super.key});
  final List<String> tabs = ['Danh bạ học sinh', 'Danh bạ giáo viên'];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DefaultTabController(
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
                        isScrollable: false,
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
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: -15),
                        tabs: _buildTabs()),
                  )),
            ),
            Flexible(
                child: TabBarView(
              children: [
                TabBarViewPhoneBook(
                  phoneBook: phoneBook,
                ),
                TabBarViewPhoneBook(
                  phoneBook: phoneBookTeacher,
                )
              ],
            ))
          ],
        ),
      ),
    );
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
