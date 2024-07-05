import 'package:core/core.dart';
import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/screens/comment/bloc/comment_bloc.dart';

class SelectFeedBackType extends StatefulWidget {
  const SelectFeedBackType({
    super.key,
    this.comment,
    this.endDate,
    this.startDate,
    required this.onSelectDate,
  });
  final Comment? comment;
  final DateTime? endDate;
  final DateTime? startDate;
  final Function(DateTime startDate, DateTime endDate) onSelectDate;
  @override
  State<SelectFeedBackType> createState() => _SelectFeedBackTypeState();
}

class _SelectFeedBackTypeState extends State<SelectFeedBackType> {
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    endDate = widget.endDate ?? DateTime.now();
    startDate = widget.startDate ?? DateTime.now();
    getFormattedDate(getWeekStartDate(startDate));
    getFormattedDate(getWeekEndDate(endDate));
    getWeekNumber(endDate);
  }

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

  int getWeekNumber(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final firstDayOfYear = DateTime(firstDayOfWeek.year);
    final daysOffset = firstDayOfYear.weekday;
    final daysOfYear = firstDayOfWeek.difference(firstDayOfYear).inDays + 1;
    return week = ((daysOfYear - daysOffset) / 7).ceil();
  }

  void getPreviousPeriodData() {
    setState(() {
      startDate = getWeekStartDate(startDate.subtract(const Duration(days: 7)));
      endDate = getWeekEndDate(endDate.subtract(const Duration(days: 7)));
    });
    getWeekNumber(endDate);
    widget.onSelectDate(startDate, endDate);
  }

  void getNextPeriodData() {
    setState(() {
      startDate = getWeekStartDate(startDate.add(const Duration(days: 7)));
      endDate = getWeekEndDate(endDate.add(const Duration(days: 7)));
    });

    getWeekNumber(endDate);
    widget.onSelectDate(startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.gray,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: getPreviousPeriodData,
              child: SvgPicture.asset(
                'assets/icons/chevron-left.svg',
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.gray400, BlendMode.srcIn),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  helpText: 'Chọn ngày',
                  cancelText: 'Trở về',
                  confirmText: 'Xong',
                  initialDate: DateTime.now(),
                  firstDate: DateTime(now.year - 3, now.month),
                  lastDate: DateTime(now.year + 1, now.month),
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
                  String formattedDate = pickedDate.ddMMyyyyDash;
                  setState(() {
                    widget.onSelectDate(pickedDate, pickedDate);
                  });
                } else {}
              },
              child: Row(
                children: [
                  Text(
                    'Tuần $week (${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)})',
                    style: AppTextStyles.semiBold14(
                      color: AppColors.brand600,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: getNextPeriodData,
              child: SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.gray400, BlendMode.srcIn),
              ),
            )
          ],
        ),
      ),
    );
  }
}
