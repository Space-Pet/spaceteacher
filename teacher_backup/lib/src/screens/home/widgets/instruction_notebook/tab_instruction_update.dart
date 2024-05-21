import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:teacher/src/screens/home/models/lesson_model.dart';

class TabInstructionUpdate extends StatelessWidget {
  const TabInstructionUpdate({
    super.key,
    required this.lessons,
  });

  final List<LessonModel> lessons;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                labelColor: AppColors.brand600,
                unselectedLabelColor: AppColors.gray500,
                dividerColor: AppColors.gray200,
                indicatorSize: TabBarIndicatorSize.tab,
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
                tabs: const [
                  Tab(
                    child: Align(
                      child: Text("Báo bài hôm nay"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Text("Báo bài đến hạn"),
                    ),
                  ),
                ]),
            // Expanded(
            //   child: TabBarView(children: [
            //     SingleChildScrollView(
            //       child: ExerciseItemList(
            //         exercise: exercises,
            //         isHomeScreenView: true,
            //         isTodayView: true,
            //         selectedSubject: "Tất cả các môn",
            //       ),
            //     ),
            //     SingleChildScrollView(
            //       child: ExerciseItemList(
            //         isHomeScreenView: true,
            //         exercise: exercises,
            //         selectedSubject: "Tất cả các môn",
            //       ),
            //     ),
            //   ]),
            // ),
          ],
        ));
  }
}
