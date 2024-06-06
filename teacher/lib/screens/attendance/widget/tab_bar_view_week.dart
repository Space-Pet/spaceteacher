import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/attendance/bloc/attendance_bloc.dart';

import 'package:timeline_tile/timeline_tile.dart';

class TabBarViewWeek extends StatefulWidget {
  final AttendanceWeek? attendanceWeek;
  final AttendanceWeek? attendanceMonth;
  final AttendanceWeek? attendanceDay;
  final int classId;
  final bool isWeek;
  final bool isDay;

  const TabBarViewWeek(
      {Key? key,
      this.isWeek = true,
      this.attendanceWeek,
      this.attendanceDay,
      this.attendanceMonth,
      this.isDay = false,
      required this.classId})
      : super(key: key);

  @override
  State<TabBarViewWeek> createState() => _TabBarViewWeekState();
}

class _TabBarViewWeekState extends State<TabBarViewWeek>
    with AutomaticKeepAliveClientMixin {
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();
  late DateTime dateDay = DateTime.now();
  late int week;
  DateFormat formatDate = DateFormat("EEEE, yyyy-MM-dd", 'vi_VN');
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

  String getDayFormattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, dd/MM/yyyy', 'vi');
    return formatter.format(date);
  }

  int getWeekNumber(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final firstDayOfYear = DateTime(firstDayOfWeek.year);
    final daysOffset = firstDayOfYear.weekday;
    final daysOfYear = firstDayOfWeek.difference(firstDayOfYear).inDays + 1;
    return week = ((daysOfYear - daysOffset) / 7).ceil();
  }

  void getPreviousPeriodData() {
    if (widget.isDay) {
      dateDay = dateDay.subtract(const Duration(days: 1));
      context.read<AttendanceBloc>().add(GetAttendanceDay(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(dateDay).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(dateDay).toString(),
          ));
    } else if (widget.isWeek && !widget.isDay) {
      setState(() {
        startDate =
            getWeekStartDate(startDate.subtract(const Duration(days: 7)));
        endDate = getWeekEndDate(endDate.subtract(const Duration(days: 7)));
      });
      getWeekNumber(endDate);
      context.read<AttendanceBloc>().add(GetAttendanceWeek(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(endDate).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(startDate).toString(),
          ));
    } else if (!widget.isWeek && !widget.isDay) {
      setState(() {
        startDate = DateTime(startDate.year, startDate.month - 1);
        endDate = DateTime(
          endDate.year,
          endDate.month - 1,
          DateTime(endDate.year, endDate.month, 0).day,
        );
      });
      getWeekNumber(endDate);
      context.read<AttendanceBloc>().add(GetAttendanceMonth(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(endDate).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(startDate).toString(),
          ));
    }
  }

  void getNextPeriodData() {
    if (widget.isDay) {
      setState(() {
        dateDay = dateDay.add(const Duration(days: 1));
      });
      context.read<AttendanceBloc>().add(GetAttendanceDay(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(dateDay).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(dateDay).toString(),
          ));
    } else if (widget.isWeek && !widget.isDay) {
      setState(() {
        startDate = getWeekStartDate(startDate.add(const Duration(days: 7)));
        endDate = getWeekEndDate(endDate.add(const Duration(days: 7)));
      });
      getWeekNumber(endDate);
      context.read<AttendanceBloc>().add(GetAttendanceWeek(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(endDate).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(startDate).toString(),
          ));
    } else if (!widget.isWeek && !widget.isDay) {
      setState(() {
        startDate = DateTime(startDate.year, startDate.month + 1);
        endDate = DateTime(endDate.year, endDate.month + 1,
            DateTime(endDate.year, endDate.month + 1 + 1, 0).day);
      });

      context.read<AttendanceBloc>().add(GetAttendanceMonth(
            classId: widget.classId,
            endDate: DateFormat('yyyy-MM-dd').format(endDate).toString(),
            startDate: DateFormat('yyyy-MM-dd').format(startDate).toString(),
          ));
    }
  }

  String formatDateString(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    getDayFormattedDate(dateDay);
    getFormattedDate(getWeekStartDate(startDate));
    getFormattedDate(getWeekEndDate(endDate));
    getWeekNumber(endDate);
  }

  @override
  Widget build(BuildContext context) {
    final currentWeekData = widget.attendanceDay?.absentData.items ??
        widget.attendanceWeek?.absentData.items ??
        widget.attendanceMonth?.absentData.items ??
        [];

    final dataListAttendance = <Map<String, dynamic>>[];

    for (final attendance in currentWeekData) {
      var isFirstDay = true;

      if (isFirstDay) {
        dataListAttendance
            .add({'day': formatDateString(attendance.date) ?? 'No date'});
        isFirstDay = false;
      }
      for (final itemData in attendance.data ?? []) {
        final dayData = <String, dynamic>{
          'description': itemData.subjectName ?? '_ _',
          'isAbsent': itemData.description ?? 'No description'
        };
        dataListAttendance.add(dayData);
      }
    }

    final listAttendance = List.generate(dataListAttendance.length, (index) {
      final data = dataListAttendance[index];

      return SizedBox(
        height: 60,
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
            height: 10,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data['day'] != null ? Colors.blue : Colors.red,
              ),
            ),
            drawGap: true,
          ),
          endChild: data['day'] != null
              ? Text(data['day'] ?? 'No data available',
                  style: AppTextStyles.normal14(
                      fontWeight: FontWeight.w600, color: AppColors.brand600))
              : Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['description'] != '' ? data['description'] : '_ _',
                        style:
                            AppTextStyles.normal12(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data['isAbsent'] ?? '',
                        style: AppTextStyles.normal12(
                            fontWeight: FontWeight.w400,
                            color: AppColors.red700),
                      )
                    ],
                  ),
                ),
        ),
      );
    });

    return BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
      final isLoading = (state.attendanceStatus ==
              AttendanceStatus.loadingAttendanceWeek) ||
          (state.attendanceStatus == AttendanceStatus.loadingAttendanceMonth) ||
          (state.attendanceStatus == AttendanceStatus.loadingAttendanceDay);
      return Padding(
        padding: const EdgeInsets.only(top: 20),
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
                    GestureDetector(
                      onTap: () async {
                        if (widget.isDay) {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            helpText: 'Chọn ngày',
                            cancelText: 'Trở về',
                            confirmText: 'Xong',
                            initialDate: dateDay,
                            firstDate: DateTime(
                                DateTime.now().year - 1, DateTime.now().month),
                            lastDate: DateTime(
                                DateTime.now().year + 1, DateTime.now().month),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.brand600,
                                    secondary: AppColors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            setState(() {
                              dateDay = pickedDate;
                            });
                            context.read<AttendanceBloc>().add(GetAttendanceDay(
                                  classId: widget.classId,
                                  endDate: DateFormat('yyyy-MM-dd')
                                      .format(dateDay)
                                      .toString(),
                                  startDate: DateFormat('yyyy-MM-dd')
                                      .format(dateDay)
                                      .toString(),
                                ));
                          } else {}
                        }
                      },
                      child: SizedBox(
                        height: 10,
                        child: Text(
                          widget.isDay
                              ? getDayFormattedDate(dateDay)
                              : widget.isWeek
                                  ? '(${startDate.ddMMSlash} - ${endDate.ddMMSlash})'
                                  : 'Tháng ${endDate.month}',
                          style: AppTextStyles.normal14(
                            height: 0.10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand600,
                          ),
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${widget.attendanceDay?.totalLessons ?? widget.attendanceWeek?.totalLessons.toString() ?? widget.attendanceMonth?.totalLessons.toString() ?? 0}',
                                    style: AppTextStyles.normal18(
                                      color: AppColors.brand600,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Tiết học',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray500,
                                      fontWeight: FontWeight.w400,
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
                                    '${widget.attendanceDay?.countPresent ?? widget.attendanceWeek?.countPresent ?? widget.attendanceMonth?.countPresent ?? 0}',
                                    style: AppTextStyles.normal18(
                                      color: AppColors.green600,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text('Có mặt',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray500,
                                        fontWeight: FontWeight.w400,
                                      ))
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
                                    '${widget.attendanceDay?.absentData.count.toString() ?? widget.attendanceWeek?.absentData.count.toString() ?? widget.attendanceMonth?.absentData.count.toString() ?? 0}',
                                    style: AppTextStyles.normal18(
                                      color: AppColors.red700,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Vắng mặt',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray500,
                                      fontWeight: FontWeight.w400,
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
              AppSkeleton(
                isLoading: isLoading,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: listAttendance,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
