import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:network_data_source/network_data_source.dart';

class WeeklyTabs extends StatelessWidget {
  const WeeklyTabs({
    super.key,
    this.lessons,
  });

  final List<DetailPlan>? lessons;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
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
                tabs: [
                  Tab(
                    child: Align(
                      child: Column(
                        children: [
                          Text('Thứ 2'),
                          SizedBox(height: 4),
                          Text(
                            lessons?[0].planmnNgay.substring(0,
                                    (lessons?[4].planmnNgay.length ?? 0) - 5) ??
                                '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Column(
                        children: [
                          Text('Thứ 3'),
                          SizedBox(height: 4),
                          Text(
                            lessons?[1].planmnNgay.substring(0,
                                    (lessons?[4].planmnNgay.length ?? 0) - 5) ??
                                '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Column(
                        children: [
                          Text('Thứ 4'),
                          SizedBox(height: 4),
                          Text(
                            lessons?[2].planmnNgay.substring(0,
                                    (lessons?[4].planmnNgay.length ?? 0) - 5) ??
                                '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Column(
                        children: [
                          Text('Thứ 5'),
                          SizedBox(height: 4),
                          Text(
                            lessons?[3].planmnNgay.substring(0,
                                    (lessons?[4].planmnNgay.length ?? 0) - 5) ??
                                '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Column(
                        children: [
                          Text('Thứ 6'),
                          SizedBox(height: 4),
                          Text(
                            lessons?[4].planmnNgay.substring(0,
                                    (lessons?[4].planmnNgay.length ?? 0) - 5) ??
                                '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    children: tabView(0),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: tabView(1),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: tabView(2),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: tabView(3),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: tabView(4),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }

  List<Container> tabView(int index) {
    return List.generate(lessons?[index].planmnDataInWeek.length ?? 0,
        (innerIndex) {
      final lesson = lessons?[index].planmnDataInWeek[innerIndex];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                width: 96,
                child: Row(
                  children: [
                    Text(
                      lesson?.planTime ?? '',
                      style: AppTextStyles.normal12(color: AppColors.black24),
                    )
                  ],
                )),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson?.planContent ?? '',
                        style:
                            AppTextStyles.semiBold14(color: AppColors.black24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson?.planContentDetail ?? '',
                        maxLines: 2,
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
