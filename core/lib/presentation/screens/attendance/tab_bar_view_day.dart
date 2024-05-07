import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../resources/resources.dart';
import '../../common_widget/select_date.dart';
import '../../extentions/date_formatter.dart';

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
      var colorAttendance = AppColors.amberA200;
      var title = '';
      switch (lesson?.attendanceType) {
        case ('so_lan'):
          title = 'Lần';
        case ('tiet_hoc'):
          title = 'Tiết';
      }
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
                        '$title ${lesson?.numberOfClassPeriod}',
                        style: AppTextStyles.normal14(color: AppColors.black24),
                      ),
                      if (lesson?.attendanceType != 'so_lan')
                        Text(
                          lesson?.roomTitle ?? '',
                          style:
                              AppTextStyles.normal12(color: AppColors.gray500),
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
                            if (lesson?.attendanceType == 'so_lan')
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  'Giờ điểm danh - ${DateFormat('HH:mm').format(DateTime.parse(lesson!.date))}',
                                  style: AppTextStyles.semiBold14(
                                      color: AppColors.black24),
                                ),
                              ),
                            if (lesson?.attendanceType != 'so_lan')
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
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
              selectDate: widget.selectDate,
              onDatePicked: (date) {
                final formattedDate = date.yyyyMMdd;
                widget.getAttendanceDay?.call(formattedDate, date);
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
