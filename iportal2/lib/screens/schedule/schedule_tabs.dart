import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ScheduleTabs extends StatefulWidget {
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
  State<ScheduleTabs> createState() => _ScheduleTabsState();
}

class _ScheduleTabsState extends State<ScheduleTabs>
    with SingleTickerProviderStateMixin {
  TabController? tabBarController;

  @override
  void initState() {
    super.initState();
    initTabBarController();
  }

  void initTabBarController() {
    if ((widget.lessons ?? []).isNotEmpty) {
      tabBarController = TabController(
        length: (widget.lessons ?? []).length,
        vsync: this,
      );
    }
  }

  @override
  void didUpdateWidget(covariant ScheduleTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lessons != oldWidget.lessons) {
      tabBarController?.dispose();
      initTabBarController();
    }
  }

  @override
  dispose() {
    tabBarController?.dispose();
    super.dispose();
  }

  Future<void> _onItemTapped(int index) async {
    tabBarController?.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat("dd/MM");

    final startOfWeek = widget.datePicked
        .subtract(Duration(days: widget.datePicked.weekday - 1));

    final days = widget.datePicked.difference(startOfWeek).inDays;

    final listTab = List.generate((widget.lessons ?? []).length, (index) {
      final date = startOfWeek.add(Duration(days: index));

      return TabDayOfWeek(
        dayOfW: 'Thứ ${index + 2}',
        date: formatDate.format(date),
      );
    });

    _onItemTapped(days);

    final listTabContent = List.generate(
        (widget.lessons ?? []).length,
        (index) => SingleChildScrollView(
              child: Column(
                children: tabView(index, startOfWeek),
              ),
            ));

    return DefaultTabController(
        length: (widget.lessons ?? []).length,
        child: Column(
          children: [
            TabBar(
              controller: tabBarController,
              onTap: (index) async {
                _onItemTapped(index);
              },
              tabs: listTab,
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

  List<Container> tabView(int index, DateTime startOfWeek) {
    final listLesson = widget.lessons?[index].dateSubject;
    bool hasAfternoon = false;

    final indexSeparate =
        listLesson!.indexWhere((element) => element.tietNum! > 5);

    if (indexSeparate != -1) {
      hasAfternoon = true;
      listLesson.insert(indexSeparate, DateSubject.empty());
    }

    return List.generate(listLesson.length, (innerIndex) {
      final lesson = listLesson[innerIndex];
      final lastIndex = listLesson.length - 1;
      final isAfternoonLesson = hasAfternoon && innerIndex < indexSeparate;

      return innerIndex == indexSeparate
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: Text(
                'Buổi chiều',
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold16(color: AppColors.brand600),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: innerIndex == lastIndex
                    ? AppRadius.roundedBottom12
                    : const BorderRadius.all(Radius.zero),
                color: AppColors.gray100,
                border: Border(
                  bottom: innerIndex == lastIndex
                      ? const BorderSide(color: AppColors.white)
                      : const BorderSide(color: AppColors.gray300),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 6),
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tiết ${isAfternoonLesson ? lesson.tietNum : lesson.tietNum! - 5}',
                              style: AppTextStyles.normal14(
                                  color: AppColors.black24),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              lesson.room ?? '',
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray61),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 4,
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
                                lesson.subjectName ?? 'Tự học',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.black24),
                              ),
                              const SizedBox(height: 4),
                              lesson.teacherName != null
                                  ? Text(
                                      'GV: ${lesson.teacherName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.normal14(
                                          color: AppColors.gray61),
                                    )
                                  : const SizedBox(height: 16),
                            ],
                          )),
                          if (lesson.subjectId != null)
                            InkWell(
                              onTap: () {
                                widget.onViewExercise(
                                  startOfWeek.add(Duration(days: index)),
                                  lesson.tietNum ?? 0,
                                );
                              },
                              child:
                                  SvgPicture.asset('assets/icons/advice.svg'),
                            ),
                        ],
                      ),
                    ),
                  ],
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
