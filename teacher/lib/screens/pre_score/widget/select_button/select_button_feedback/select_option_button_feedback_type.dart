import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';

class SelectFeedBackType extends StatefulWidget {
  const SelectFeedBackType(
      {super.key, this.comment, this.endDate, this.startDate});
  final Comment? comment;
  final DateTime? endDate;
  final DateTime? startDate;
  @override
  State<SelectFeedBackType> createState() => _SelectFeedBackTypeState();
}

class _SelectFeedBackTypeState extends State<SelectFeedBackType> {
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
    print('object: $date');
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
    context.read<PreScoreBloc>().add(GetComment(
        txtDate: DateFormat('dd-MM-yyyy').format(startDate).toString(),
        inputEndDate: endDate,
        inputStartDate: startDate));
  }

  void getNextPeriodData() {
    setState(() {
      startDate = getWeekStartDate(startDate.add(const Duration(days: 7)));
      endDate = getWeekEndDate(endDate.add(const Duration(days: 7)));
    });

    getWeekNumber(endDate);
    context.read<PreScoreBloc>().add(GetComment(
        txtDate: DateFormat('dd-MM-yyyy').format(startDate).toString(),
        inputEndDate: endDate,
        inputStartDate: startDate));
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
            Row(
              children: [
                Text(
                  'Tuần $week (${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)})',
                  style: AppTextStyles.semiBold14(
                    color: AppColors.brand600,
                  ),
                ),
              ],
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
