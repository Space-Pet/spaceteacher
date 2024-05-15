import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/home/models/lesson_model.dart';

import '../../schedule/schedule_screen.dart';

class TabBarViewDay extends StatelessWidget {
  const TabBarViewDay({
    super.key,
    required this.lessons,
  });

  final List<LessonModel> lessons;

  @override
  Widget build(BuildContext context) {
    final lessonsWExpanded = List.generate(lessons.length, (index) {
      final lesson = lessons[index];
      Color colorAttendance = AppColors.amberA200;
      switch (lesson.attendance) {
        case ('Có mặt'):
          colorAttendance = AppColors.green600;
        case ('Vắng có phép'):
          colorAttendance = AppColors.red700;
      }
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: index == lessons.length - 1
                  ? AppRadius.roundedBottom12
                  : index == 0
                      ? AppRadius.roundedTop12
                      : const BorderRadius.all(Radius.zero),
              color: AppColors.gray100,
              border: Border(
                bottom: index == lessons.length - 1
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.gray300),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 6),
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tiết ${lesson.number}',
                        style: AppTextStyles.normal14(
                            color: AppColors.black24,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${lesson.room}',
                        style: AppTextStyles.normal12(
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.brand600,
                      borderRadius: BorderRadius.circular(14)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                lesson.name ?? "",
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.black24),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                '${lesson.attendance}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.normal12(
                                    color: colorAttendance),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: SelectDate(),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [...lessonsWExpanded],
          ),
        ),
      ],
    );
  }
}
