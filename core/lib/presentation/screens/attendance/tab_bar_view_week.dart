import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../data/models/models.dart';
import '../../../resources/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../extentions/extention.dart';

class CTabBarViewDays extends StatefulWidget {
  final AttendanceWeek? attendanceWeek;
  final bool isWeek;
  final DateTime selectDate;

  const CTabBarViewDays({
    super.key,
    this.attendanceWeek,
    this.isWeek = true,
    this.getAttendanceWeek,
    this.getAttendanceMonth,
    required this.selectDate,
  });

  final void Function(String endDate, String startDate)? getAttendanceWeek;
  final void Function(String endDate, String startDate)? getAttendanceMonth;

  @override
  State<CTabBarViewDays> createState() => _CTabBarViewDaysState();
}

class _CTabBarViewDaysState extends State<CTabBarViewDays> {
  late DateTime startDate;
  late DateTime endDate;
  late int week;

  DateTime getWeekStartDate(DateTime date) {
    return startDate = date.subtract(Duration(days: date.weekday - 1));
  }

  DateTime getWeekEndDate(DateTime date) {
    return endDate =
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  String getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}';
  }

  void getPreviousPeriodData() {
    if (widget.isWeek) {
      setState(() {
        startDate =
            getWeekStartDate(startDate.subtract(const Duration(days: 7)));
        endDate = getWeekEndDate(endDate.subtract(const Duration(days: 7)));
      });
      widget.getAttendanceWeek?.call(endDate.yyyyMMdd, startDate.yyyyMMdd);
    } else {
      setState(() {
        startDate = DateTime(startDate.year, startDate.month - 1);
        endDate = DateTime(
          endDate.year,
          endDate.month - 1,
          DateTime(endDate.year, endDate.month, 0).day,
        );
      });
      widget.getAttendanceMonth?.call(endDate.yyyyMMdd, startDate.yyyyMMdd);
    }
  }

  void getNextPeriodData() {
    if (widget.isWeek) {
      startDate = getWeekStartDate(startDate.add(const Duration(days: 7)));
      endDate = getWeekEndDate(endDate.add(const Duration(days: 7)));
      widget.getAttendanceWeek?.call(endDate.yyyyMMdd, startDate.yyyyMMdd);
    } else {
      startDate = DateTime(startDate.year, startDate.month + 1);
      endDate = DateTime(endDate.year, endDate.month + 1,
          DateTime(endDate.year, endDate.month + 1 + 1, 0).day);
      widget.getAttendanceMonth?.call(endDate.yyyyMMdd, startDate.yyyyMMdd);
    }
  }

  @override
  void initState() {
    super.initState();
    getFormattedDate(getWeekStartDate(widget.selectDate));
    getFormattedDate(getWeekEndDate(widget.selectDate));
  }

  @override
  Widget build(BuildContext context) {
    final currentWeekData = widget.attendanceWeek?.absentData.items ?? [];

    final dataListAttendance = <Map<String, dynamic>>[];

    for (final attendance in currentWeekData) {
      var isFirstDay = true;

      if (isFirstDay) {
        print(attendance.date);
        final formattedDate =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(attendance.date));

        dataListAttendance.add({'day': formattedDate});
        isFirstDay = false;
      }
      for (final itemData in attendance.data) {
        final dayData = <String, dynamic>{
          'description': itemData.subjectName,
          'isAbsent': itemData.description
        };
        dataListAttendance.add(dayData);
      }
    }

    final listAttendance = List.generate(dataListAttendance.length, (index) {
      final data = dataListAttendance[index];
      return SizedBox(
        height: 44,
        width: double.infinity,
        child: TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05,
          isFirst: index == 0,
          afterLineStyle: const LineStyle(
            thickness: 1,
            color: AppColors.gray300,
          ),
          beforeLineStyle: const LineStyle(
            thickness: 1,
            color: AppColors.gray300,
          ),
          indicatorStyle: IndicatorStyle(
            height: 8,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data['day'] != null ? AppColors.brand600 : Colors.red,
                boxShadow: data['day'] != null
                    ? null
                    : [
                        const BoxShadow(
                          color: Color.fromARGB(255, 226, 155, 150),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
              ),
            ),
            drawGap: true,
          ),
          endChild: data['day'] != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                      data['day'] ??
                          '${data['description']} ${data['isAbsent']}',
                      style: AppTextStyles.normal14(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brand600)),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['description'] ?? '',
                        style:
                            AppTextStyles.normal12(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data['isAbsent'] ?? '',
                        style: AppTextStyles.normal12(color: AppColors.red700),
                      )
                    ],
                  ),
                ),
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.error100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: widget.isWeek == true
                      ? Assets.images.ateendancePink.provider()
                      : Assets.images.attendanceBlue.provider(),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: getPreviousPeriodData,
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 28,
                      color: AppColors.gray500,
                    ),
                  ),
                  Text(
                    widget.isWeek
                        ? '${DateFormat('dd/MM').format(startDate)} - ${DateFormat('dd/MM').format(endDate)}'
                        : 'Tháng ${endDate.month}',
                    style: AppTextStyles.normal14(
                      height: 0.10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brand600,
                    ),
                  ),
                  IconButton(
                    onPressed: getNextPeriodData,
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 28,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  color: widget.isWeek == true
                      ? const Color.fromARGB(255, 247, 245, 245)
                      : const Color.fromARGB(255, 245, 245, 245),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.attendanceWeek?.totalLessons.toString() ?? 0}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.brand600,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Tiết học',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.gray300,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.attendanceWeek?.countPresent ?? 0}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.green600,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Có mặt',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.gray300,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.attendanceWeek?.absentData.count.toString() ?? 0}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.red700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Vắng',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Text(
                    'Tổng kết số tiết vắng',
                    style: AppTextStyles.normal16(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: listAttendance,
              ),
            )
          ],
        ),
      ),
    );
  }
}
