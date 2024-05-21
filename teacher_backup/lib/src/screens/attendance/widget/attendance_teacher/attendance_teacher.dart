import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/attendance_qr/attendance_qr_screen.dart';

import 'package:teacher/src/screens/home/models/lesson_model.dart';
import 'package:teacher/src/screens/schedule/schedule_screen.dart';

class AttendanceTeacher extends StatefulWidget {
  const AttendanceTeacher({
    super.key,
    required this.lessons,
  });
  final List<LessonModel> lessons;

  @override
  State<AttendanceTeacher> createState() => _AttendanceTeacherState();
}

class _AttendanceTeacherState extends State<AttendanceTeacher>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ['Lớp giảng dạy', 'Lớp chủ nhiệm'];

  @override
  Widget build(BuildContext context) {
    final startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

    final listTabContent = List.generate(
        2,
        (index) => SingleChildScrollView(
              child: Column(
                children: tabView(index, startOfWeek, context),
              ),
            ));
    return Expanded(
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SelectDate(),
              TabBar(
                padding: const EdgeInsets.only(top: 16),
                labelPadding: EdgeInsets.zero,
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
                tabs: _buildTabs(),
              ),
              Expanded(
                child: TabBarView(
                  children: listTabContent,
                ),
              ),
            ],
          )),
    );
  }

  List<Container> tabView(
      int index, DateTime startOfWeek, BuildContext context) {
    return List.generate(9, (innerIndex) {
      // final lesson = widget.lessons?[index].dateSubject[innerIndex];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.gray100,
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
                      'Tiết 1',
                      style: AppTextStyles.normal14(color: AppColors.black24),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'P.310',
                      style: AppTextStyles.normal14(color: AppColors.gray61),
                    ),
                  ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lớp 6.1',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold14(
                                  color: AppColors.black24),
                            ),
                            Row(
                              children: [
                                Assets.icons.checkAbsent.svg(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Vắng (2)',
                                    style: AppTextStyles.normal12(
                                        color: AppColors.orange400),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vắng có phép: Nhung, Trang',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.normal12(color: AppColors.red),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bài 2: Diện tích hình tròn',
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.normal12(color: AppColors.gray700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'GV: Huy Van',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.normal12(color: AppColors.gray61),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.red900)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AttendanceQRScreen(
                                            type: 1,
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Điểm danh',
                                  style: AppTextStyles.normal12(
                                      color: AppColors.red900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Assets.icons.checkFull.svg(
                                    color: AppColors.red900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AttendanceQRScreen(
                                          type: 2,
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.red900),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Điểm danh QR',
                                  style: AppTextStyles.normal12(
                                      color: AppColors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Assets.icons.qrCode.svg(
                                    color: AppColors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
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

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }
}

class TabDayOfWeek extends StatelessWidget {
  const TabDayOfWeek({
    super.key,
    required this.dayOfW,
  });

  final String dayOfW;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        child: Column(
          children: [
            Text(dayOfW,
                style: AppTextStyles.semiBold14(color: AppColors.brand600)),
          ],
        ),
      ),
    );
  }
}
