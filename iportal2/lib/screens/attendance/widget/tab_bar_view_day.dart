import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:network_data_source/network_data_source.dart';

class TabBarViewDay extends StatefulWidget {
  const TabBarViewDay({
    super.key,
    this.lessons,
  });

  final List<AttendanceDay>? lessons;

  @override
  State<TabBarViewDay> createState() => _TabBarViewDayState();
}

class _TabBarViewDayState extends State<TabBarViewDay> {
  @override
  Widget build(BuildContext context) {
    final lessonsWExpanded =
        List.generate(widget.lessons?.length ?? 0, (index) {
      final lesson = widget.lessons?[index];
      Color colorAttendance = AppColors.amberA200;
      switch (lesson?.status) {
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
              borderRadius: index == (widget.lessons?.length ?? 0) - 1
                  ? AppRadius.roundedBottom12
                  : index == 0
                      ? AppRadius.roundedTop12
                      : const BorderRadius.all(Radius.zero),
              color: AppColors.gray100,
              border: Border(
                bottom: index == (widget.lessons?.length ?? 0) - 1
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
                        'Tiết ${lesson?.numberOfClassPeriod}',
                        style: AppTextStyles.normal14(color: AppColors.black24),
                      ),
                      Text(
                        lesson?.roomTitle ?? '',
                        style: AppTextStyles.normal12(color: AppColors.gray500),
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
                                lesson?.subjectName ?? '',
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.black24),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                lesson?.status ?? '',
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
        Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: SelectDate(
              onDatePicked: (date) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                print("Selected date in parent: $formattedDate");
                setState(() {
                  context
                      .read<AttendanceBloc>()
                      .add(GetAttendanceDay(date: formattedDate));
                });
              },
            )),
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
