import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

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
    final teacherId = context.read<CurrentUserBloc>().state.user.teacher_id;
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
                children: tabView(index, startOfWeek, teacherId.toString()),
              ),
            ));

    // _onItemTapped(days);

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

  List<Container> tabView(int index, DateTime startOfWeek, String? teacherId) {
    return List.generate(widget.lessons?[index].dateSubject.length ?? 0,
        (innerIndex) {
      final lesson = widget.lessons?[index].dateSubject[innerIndex];
      final lastIndex = (widget.lessons?[index].dateSubject.length ?? 0) - 1;

      return Container(
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
                              lesson?.teacherId == teacherId
                                  ? 'GVCN: ${lesson?.teacherName}'
                                  : 'GV: ${lesson?.teacherName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray61),
                            )
                          : const SizedBox(height: 16),
                    ],
                  )),
                  // if (lesson?.subjectId != null)
                  //   InkWell(
                  //     onTap: () {
                  //       widget.onViewExercise(
                  //         startOfWeek.add(Duration(days: index)),
                  //         lesson?.tietNum ?? 0,
                  //       );
                  //     },
                  //     child: SvgPicture.asset('assets/icons/advice.svg'),
                  //   ),
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
