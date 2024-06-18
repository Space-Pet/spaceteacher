import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../resources/resources.dart';
import '../../common_widget/export.dart';
import '../../common_widget/select_date.dart';
import '../../extentions/extention.dart';

class CTabBarViewDay extends StatefulWidget {
  const CTabBarViewDay({
    super.key,
    this.lessons,
    this.selectDate,
    this.getAttendanceDay,
  });

  final List<AttendanceDay>? lessons;
  final DateTime? selectDate;
  final void Function(String formattedDate, DateTime selectedDate)?
      getAttendanceDay;

  @override
  State<CTabBarViewDay> createState() => _CTabBarViewDayState();
}

class _CTabBarViewDayState extends State<CTabBarViewDay> {
  @override
  Widget build(BuildContext context) {
    final lessonsWExpanded =
        List.generate(widget.lessons?.length ?? 0, (index) {
      final lesson = widget.lessons?[index];

      if (lesson == null) {
        return const SizedBox();
      }

      var colorAttendance = AppColors.amberA200;
      var title = '';

      print(lesson.attendanceType);

      switch (lesson.attendanceType) {
        case ('so_lan'):
          title = 'Lần';
        case ('tiet_hoc'):
          title = 'Tiết';
      }
      switch (lesson.status) {
        case ('Có mặt'):
          colorAttendance = AppColors.green600;
        case ('Vắng có phép'):
          colorAttendance = AppColors.red700;
      }

      return Container(
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 6),
                width: 130.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // '$title ${lesson?.numberOfClassPeriod}',
                      'Lúc: ${DateFormat('HH:mm').format(DateTime.parse(lesson.date))}',
                      style: AppTextStyles.semiBold14(color: AppColors.black24),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'GV: ${lesson.teacherName}',
                      style: AppTextStyles.normal14(color: AppColors.gray600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Container(
                width: 4,
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
                          lesson.attendanceType == 'so_lan'
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Lần điểm danh ${lesson.numberOfClassPeriod}',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.black24),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    lesson.subjectName,
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.black24),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              lesson.status,
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
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: SelectDate(
              selectDate: widget.selectDate,
              onDatePicked: (date) {
                final formattedDate = date.yyyyMMdd;
                widget.getAttendanceDay?.call(formattedDate, date);
              },
            )),
        Expanded(
          child: (widget.lessons ?? []).isNotEmpty
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [...lessonsWExpanded],
                )
              : const EmptyScreen(text: 'Không có dữ liệu'),
        )
      ],
    );
  }
}
