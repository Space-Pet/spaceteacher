import 'package:core/core.dart';
import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/menu/widgets/menu_component.dart';

class TabMenu extends StatelessWidget {
  const TabMenu({super.key, required this.dataMenu});

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

  List<Widget> tabView(int index, BuildContext context) {
    final groupedMenus = groupByCategory(dataMenu[index].dataInWeek);

    return groupedMenus.entries.map((entry) {
      final category = entry.key;
      final menus = entry.value;
      final categoryIndex = groupedMenus.keys.toList().indexOf(category);
      final outerContainerColor =
          categoryIndex % 2 == 0 ? AppColors.lightSkyBlue : AppColors.lightPink;

      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              color: outerContainerColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  category,
                  style: AppTextStyles.normal14(
                      fontWeight: FontWeight.w600, color: AppColors.brand600),
                ),
              ),
              ...menus.map((menu) {
                menus.indexOf(menu);
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowPopupMenu(
                        item: menu,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 60,
                                  maxWidth: 100,
                                  minHeight: 50,
                                  minWidth: 100,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      5), // Border radius of 20
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    menu.picture == ''
                                        ? 'https://via.placeholder.com/500x500.png?text=No+Image+Available'
                                        : menu.picture,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        2,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Assets.icons.pizza
                                            //     .svg(color: AppColors.green400),
                                            SvgPicture.asset(
                                              Assets.icons.pizza,
                                              color: AppColors.green600,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  menu.title,
                                                  style:
                                                      AppTextStyles.normal12(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              Assets.icons.flame,
                                              color: AppColors.orange400,
                                            ),
                                            // Assets.icons.flame.svg(
                                            //     color: AppColors.orange400),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  menu.calo,
                                                  style:
                                                      AppTextStyles.normal12(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }).toList();
  }

  Map<String, List<DataInWeek>> groupByCategory(List<DataInWeek> dataInWeek) {
    final Map<String, List<DataInWeek>> grouped = {};
    for (final item in dataInWeek) {
      if (!grouped.containsKey(item.category)) {
        grouped[item.category] = [];
      }
      grouped[item.category]!.add(item);
    }
    return grouped;
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
