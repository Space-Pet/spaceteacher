import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ScheduleTabs extends StatelessWidget {
  const ScheduleTabs({
    super.key,
    this.lessons,
    required this.datePicked,
    required this.onViewExercise,
  });

  final List<ScheduleData>? lessons;
  final DateTime datePicked;
  final Function(DateTime date, int tietNum) onViewExercise;

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat("dd/MM");

    final startOfWeek =
        datePicked.subtract(Duration(days: datePicked.weekday - 1));

    final listTab = List.generate((lessons ?? []).length, (index) {
      final date = startOfWeek.add(Duration(days: index));

      return TabDayOfWeek(
        dayOfW: 'Thứ ${index + 2}',
        date: formatDate.format(date),
      );
    });

    final listTabContent = List.generate(
        (lessons ?? []).length,
        (index) => SingleChildScrollView(
              child: Column(
                children: tabView(index, startOfWeek),
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

  List<Container> tabView(int index, DateTime startOfWeek) {
    return List.generate(lessons?[index].dateSubject.length ?? 0, (innerIndex) {
      final lesson = lessons?[index].dateSubject[innerIndex];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: index == (lessons?.length ?? 0) - 1
              ? AppRadius.roundedBottom12
              : const BorderRadius.all(Radius.zero),
          color: AppColors.gray100,
          border: Border(
            bottom: index == (lessons?.length ?? 0) - 1
                ? BorderSide.none
                : const BorderSide(color: AppColors.gray300),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 6),
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiết ${lesson?.tietNum}',
                      style: AppTextStyles.normal14(color: AppColors.black24),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson?.room ?? '',
                      style: AppTextStyles.normal14(color: AppColors.gray61),
                    ),
                  ],
                )),
            Expanded(
              child: Row(
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
                        lesson?.subjectName ?? 'Tiết trống',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextStyles.semiBold14(color: AppColors.black24),
                      ),
                      const SizedBox(height: 4),
                      lesson?.teacherName != null
                          ? Text(
                              'GV: ${lesson?.teacherName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray61),
                            )
                          : const SizedBox(height: 16),
                    ],
                  )),
                  if (lesson?.subjectId != null)
                    InkWell(
                      onTap: () {
                        onViewExercise(
                          startOfWeek.add(Duration(days: index)),
                          lesson?.tietNum ?? 0,
                        );
                      },
                      child: SvgPicture.asset('assets/icons/advice.svg'),
                    ),
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
