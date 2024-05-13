import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/menu/widgets/menu_component.dart';

class TabMenu extends StatelessWidget {
  TabMenu({super.key, required this.dataMenu});
  final List<DataMenu> dataMenu;
  @override
  Widget build(BuildContext context) {
    final listTab = List.generate((dataMenu).length, (index) {
      return TabDayOfWeek(
        date: dataMenu[index].thucDonNgay.substring(0, 5),
        dayOfW: 'Thứ ${index + 2}',
      );
    });

    final listTabContent = List.generate(
      dataMenu.length,
      (index) => SingleChildScrollView(
        child: Column(
          children: tabView(index, context),
        ),
      ),
    );

    return DefaultTabController(
      length: dataMenu.length,
      child: Expanded(
        child: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.all(0),
              labelPadding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              labelColor: AppColors.brand600,
              tabAlignment: TabAlignment.fill,
              unselectedLabelColor: AppColors.gray500,
              dividerColor: AppColors.gray200,
              labelStyle: AppTextStyles.semiBold14(color: AppColors.brand600),
              unselectedLabelStyle:
                  AppTextStyles.normal14(color: AppColors.gray500),
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                color: AppColors.gray100,
              ),
              tabs: listTab,
            ),
            Expanded(
              child: TabBarView(
                children: listTabContent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> imagePaths = [
    'assets/images/breakfast.png',
    'assets/images/lunch.png',
    'assets/images/brunch.png',
    'assets/images/dinner.png',
    'assets/images/breakfast.png',
    'assets/images/lunch.png',
    'assets/images/brunch.png',
    'assets/images/dinner.png',
    'assets/images/breakfast.png',
    'assets/images/lunch.png',
    'assets/images/brunch.png',
    'assets/images/dinner.png',
  ];

  List<Widget> tabView(int index, BuildContext context) {
    return List.generate(dataMenu[index].dataInWeek.length, (innerIndex) {
      final menu = dataMenu[index].dataInWeek[innerIndex];
      final imagePathIndex = innerIndex;
      print('index: ${dataMenu[index].dataInWeek.length}, $innerIndex');
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => ShowPopupMenu(
                item: menu,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: innerIndex % 2 == 0
                    ? AppColors.lightSkyBlue
                    : AppColors.lightPink,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        menu.category,
                        style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand600),
                      ),
                      Text(
                        'Xem hình ảnh',
                        style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 2,
                                  child: Text(
                                    menu.title,
                                    style: AppTextStyles.normal12(),
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Image.asset(imagePaths[imagePathIndex]),
                          ), // Remove Padding widget wrapping Image
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TabDayOfWeek extends StatelessWidget {
  const TabDayOfWeek({
    super.key,
    required this.dayOfW,
    required this.date,
  });

  final String dayOfW;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        child: Column(
          children: [
            Text(dayOfW,
                style: AppTextStyles.semiBold14(color: AppColors.brand600)),
            const SizedBox(height: 4),
            Text(
              date,
              style: AppTextStyles.normal14(),
            ),
          ],
        ),
      ),
    );
  }
}
