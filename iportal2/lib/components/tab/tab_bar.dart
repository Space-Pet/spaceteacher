import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';

class TabBarFlexible extends StatelessWidget {
  final List<String> tabTitles;
  final List<List<Widget>> tabContent;

  const TabBarFlexible({
    super.key,
    required this.tabTitles,
    required this.tabContent,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DefaultTabController(
        length: tabTitles.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
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
                    unselectedLabelColor: AppColors.gray700,
                    isScrollable: false,
                    dividerColor: Colors.transparent,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w400),
                    indicator: BoxDecoration(
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
            Flexible(
              child: TabBarView(
                children: _buildTabViews(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabTitles.map((title) {
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

  List<Widget> _buildTabViews() {
    List<Widget> tabViews = [];
    for (int i = 0; i < tabContent.length; i++) {
      tabViews.add(
        SingleChildScrollView(
          child: Column(
            children: tabContent[i],
          ),
        ),
      );
    }
    return tabViews;
  }
}
