import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class WeeklyTabs extends StatelessWidget {
  const WeeklyTabs({
    super.key,
    this.lessons,
  });

  final List<DetailPlan>? lessons;

  @override
  Widget build(BuildContext context) {
    final listTab = List.generate((lessons ?? []).length, (index) {
      return TabDayOfWeek(
        date: lessons?[index].planmnNgay.substring(0, 5) ?? '',
        dayOfW: 'Thứ ${index + 2}',
      );
    });

    final listTabContent = List.generate(
        (lessons ?? []).length,
        (index) => SingleChildScrollView(
              child: Column(
                children: tabView(index),
              ),
            ));

    return DefaultTabController(
        length: (lessons ?? []).length,
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
        ));
  }

  List<Container> tabView(int index) {
    return List.generate(lessons?[index].planmnDataInWeek.length ?? 0,
        (innerIndex) {
      final lesson = lessons?[index].planmnDataInWeek[innerIndex];
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextStyles.semiBold14(color: AppColors.black24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson?.planContentDetail ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normal12(color: AppColors.gray61),
                      ),
                    ],
                  )),
                ],
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
