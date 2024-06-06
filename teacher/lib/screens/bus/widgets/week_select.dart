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
  const WeekSelect({super.key, this.date, this.onDatePicked});
  final DateTime? date;
  final Function(DateTime date)? onDatePicked;

  @override
  State<WeekSelect> createState() => _WeekSelectState();
}

class _WeekSelectState extends State<WeekSelect> {
  late DateTime selectedDate;
  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late WeekSelectModel weekSchedule;
  late List<String> daysOfWeek;
  late List<DateTime> datesOfWeek;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date ?? DateTime.now();
    weekSchedule = getWeek(selectedDate);
    daysOfWeek = getDaysOfWeek(selectedDate);
    datesOfWeek = getDatesOfWeek(selectedDate);
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

  List<String> getDaysOfWeek(DateTime date) {
    DateFormat dayFormat = DateFormat("EEE", 'vi_VN');
    DateFormat dateFormat = DateFormat("dd", 'vi_VN');
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    List<String> days = [];
    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      days.add("${dayFormat.format(day)}\n${dateFormat.format(day)}");
    }
    return days;
  }

  List<DateTime> getDatesOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    List<DateTime> dates = [];
    for (int i = 0; i < 7; i++) {
      dates.add(startOfWeek.add(Duration(days: i)));
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: const BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = formatDate.parse(weekSchedule.preWeek);
                        weekSchedule = getWeek(selectedDate);
                        daysOfWeek = getDaysOfWeek(selectedDate);
                        datesOfWeek = getDatesOfWeek(selectedDate);
                        widget.onDatePicked?.call(selectedDate);
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
                          selectableDayPredicate: (DateTime date) {
                            return true; // Allow all days to be selectable
                          },
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(const Duration(
                              days: 365 * 100)), // Past 100 years
                          lastDate: DateTime.now().add(const Duration(
                              days: 365 * 100)), // Next 100 years
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
                            selectedDate = pickedDate;
                            weekSchedule = getWeek(pickedDate);
                            daysOfWeek = getDaysOfWeek(pickedDate);
                            datesOfWeek = getDatesOfWeek(pickedDate);
                            widget.onDatePicked?.call(pickedDate);
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          '${weekSchedule.startOfWeek} - ${weekSchedule.endOfWeek}',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = formatDate.parse(weekSchedule.nextWeek);
                        weekSchedule = getWeek(selectedDate);
                        daysOfWeek = getDaysOfWeek(selectedDate);
                        datesOfWeek = getDatesOfWeek(selectedDate);
                        widget.onDatePicked?.call(selectedDate);
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(daysOfWeek.length, (index) {
                  bool isSelected = selectedDate == datesOfWeek[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = datesOfWeek[index];
                        weekSchedule = getWeek(selectedDate);
                        daysOfWeek = getDaysOfWeek(selectedDate);
                        datesOfWeek = getDatesOfWeek(selectedDate);
                        widget.onDatePicked?.call(selectedDate);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.brand600
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        daysOfWeek[index],
                        style: AppTextStyles.normal12(
                          color: isSelected ? Colors.white : AppColors.gray500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
