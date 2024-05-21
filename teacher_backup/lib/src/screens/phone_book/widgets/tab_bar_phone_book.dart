import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/textfield/input_text.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/phone_book/widgets/tab_bar_view_phone_book.dart';

class TabBarPhoneBook extends StatefulWidget {
  const TabBarPhoneBook({super.key});

  @override
  State<TabBarPhoneBook> createState() => _TabBarPhoneBookState();
}

class _TabBarPhoneBookState extends State<TabBarPhoneBook> {
  final List<String> tabs = ['Học sinh', 'Cha mẹ học sinh', 'Giáo viên'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              child: TitleAndInputText(
                obscureText: false,
                hintText: 'Tìm kiếm',
                onChanged: (value) {
                  setState(() {});
                },
                prefixIcon: Assets.images.search.image(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TabBar(
                padding: const EdgeInsets.all(0),
                labelColor: AppColors.brand600,
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
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  color: AppColors.white,
                ),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -20),
                tabs: _buildTabs(),
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [
                TabBarViewPhoneBook(
                  index: 0,
                ),
                TabBarViewPhoneBook(
                  index: 1,
                ),
                TabBarViewPhoneBook(
                  index: 2,
                )
              ],
            ))
          ],
        ));
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
