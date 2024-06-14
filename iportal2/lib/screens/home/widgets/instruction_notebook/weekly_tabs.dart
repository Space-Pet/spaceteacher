import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class WeeklyTabs extends StatefulWidget {
  const WeeklyTabs({
    super.key,
    this.lessons,
    required this.date,
  });

  final List<DetailPlan>? lessons;
  final DateTime date;

  @override
  State<WeeklyTabs> createState() => _WeeklyTabsState();
}

class _WeeklyTabsState extends State<WeeklyTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      length: (widget.lessons ?? []).length,
      vsync: this,
    );
  }

  Future<void> _onItemTapped(int index) async {
    tabBarController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final startOfWeek =
        widget.date.subtract(Duration(days: widget.date.weekday - 1));
    final days = widget.date.difference(startOfWeek).inDays;

    final listTab = List.generate((widget.lessons ?? []).length, (index) {
      return TabDayOfWeek(
        date: widget.lessons?[index].planmnNgay.substring(0, 5) ?? '',
        dayOfW: 'Thứ ${index + 2}',
      );
    });

    final listTabContent = List.generate(
        (widget.lessons ?? []).length,
        (index) => SingleChildScrollView(
              child: Column(
                children: tabView(index),
              ),
            ));

    _onItemTapped(days);

    return DefaultTabController(
        length: (widget.lessons ?? []).length,
        child: Column(
          children: [
            TabBar(
              controller: tabBarController,
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
                
                controller: tabBarController,
                children: listTabContent,
              ),
            ),
          ],
        ));
  }

  List<Container> tabView(int index) {
    return List.generate(widget.lessons?[index].planmnDataInWeek.length ?? 0,
        (innerIndex) {
      final lesson = widget.lessons?[index].planmnDataInWeek[innerIndex];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.zero),
          color: AppColors.gray100,
          border: Border(
            bottom: BorderSide(color: AppColors.gray300),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 6),
                width: 100,
                child: Text(
                  lesson?.planTime ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.normal12(color: AppColors.black24),
                )),
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.brand600,
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          lesson?.planContent ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.semiBold14(
                              color: AppColors.black24),
                        ),
                        const SizedBox(height: 4),
                        if (lesson?.planContentDetail != '')
                          Text(
                            lesson?.planContentDetail ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTextStyles.normal12(color: AppColors.gray61),
                          ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
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
