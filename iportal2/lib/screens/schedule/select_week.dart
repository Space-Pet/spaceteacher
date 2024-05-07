import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:core/resources/resources.dart';

class WeekSelectModel {
  final String startOfWeek;
  final String endOfWeek;
  final String preWeek;
  final String nextWeek;

  const WeekSelectModel({
    required this.startOfWeek,
    required this.endOfWeek,
    required this.preWeek,
    required this.nextWeek,
  });
}

class WeekSelect extends StatefulWidget {
  const WeekSelect({super.key, required this.date, this.onDatePicked});
  final DateTime date;
  final Function(DateTime date)? onDatePicked;

  @override
  State<WeekSelect> createState() => _WeekSelectState();
}

class _WeekSelectState extends State<WeekSelect> {
  DateTime now = DateTime.now();
  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late WeekSelectModel weekSchedule;

  @override
  void initState() {
    super.initState();
    weekSchedule = getWeek(now);
  }

  WeekSelectModel getWeek(DateTime date) {
    DateFormat formatDate = DateFormat("dd/MM/yyyy", 'vi_VN');

    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final startOfNextWeek = endOfWeek.add(const Duration(days: 1));
    final startOfPreWeek = startOfWeek.subtract(const Duration(days: 7));

    return WeekSelectModel(
      startOfWeek: formatDate.format(startOfWeek),
      endOfWeek: formatDate.format(endOfWeek),
      preWeek: formatDate.format(startOfPreWeek),
      nextWeek: formatDate.format(startOfNextWeek),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: const BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onDatePicked
                      ?.call(formatDate.parse(weekSchedule.preWeek));

                  setState(() {
                    weekSchedule =
                        getWeek(formatDate.parse(weekSchedule.preWeek));
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      helpText: 'Chọn ngày',
                      cancelText: 'Trở về',
                      confirmText: 'Xong',
                      initialDate: widget.date,
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
                      widget.onDatePicked?.call(pickedDate);

                      setState(() {
                        weekSchedule = getWeek(pickedDate);
                      });
                    } else {}
                  },
                  child: Center(
                    child: Text(
                      '${weekSchedule.startOfWeek} - ${weekSchedule.endOfWeek}',
                      style:
                          AppTextStyles.semiBold14(color: AppColors.brand600),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onDatePicked
                      ?.call(formatDate.parse(weekSchedule.nextWeek));

                  setState(() {
                    weekSchedule =
                        getWeek(formatDate.parse(weekSchedule.nextWeek));
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
