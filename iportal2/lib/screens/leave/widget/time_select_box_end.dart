import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TimeSelectBoxEnd extends StatefulWidget {
  const TimeSelectBoxEnd({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    this.dateEnd,
    this.dateStart,
    required this.helpText,
    this.canSelectTime = true,
    required this.onTimeChanged,
    required this.onDateChanged,
  });

  final String title;
  final DateTime date;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final TimeOfDay time;
  final String helpText;
  final bool canSelectTime;
  final Function(DateTime) onTimeChanged;
  final Function(DateTime) onDateChanged;

  @override
  State<TimeSelectBoxEnd> createState() => TimeSelectBoxEndState();
}

class TimeSelectBoxEndState extends State<TimeSelectBoxEnd> {
  TimeOfDay? selectedTime;
  DateFormat formatDate = DateFormat('EEEE, dd/MM/yyyy', 'vi');
  DateTime now = DateTime.now().add(const Duration(days: 1));
  late String datePicked;
  late String dataTime;
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: selectedTime != null
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        )
                      : DateTime(
                          widget.date.year,
                          widget.date.month,
                          widget.date.day,
                          widget.time.hour,
                          widget.time.minute,
                        ),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      selectedTime = TimeOfDay.fromDateTime(newDateTime);
                      dataTime =
                          '${selectedTime!.hourOfPeriod}:${selectedTime!.minute} ${selectedTime!.period == DayPeriod.am ? 'AM' : 'PM'}';
                    });
                    widget.onTimeChanged(newDateTime);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        dataTime =
            '${pickedTime.hourOfPeriod}:${pickedTime.minute} ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(now);
    dataTime =
        '${widget.time.hourOfPeriod}:${widget.time.minute} ${widget.time.period == DayPeriod.am ? 'AM' : 'PM'}';
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialDate = widget.date.add(const Duration(days: 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.normal14(color: AppColors.textNormalColor),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.gray400,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      helpText: widget.helpText,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      cancelText: 'Trở về',
                      confirmText: 'Xong',
                      initialDate: widget.date.add(const Duration(days: 1)),
                      // initialDate: widget.date ==
                      //         DateTime.now().subtract(Duration(days: 1))
                      //     ? widget.date
                      //     : widget.date.add(Duration(days: 2)),
                      firstDate: widget.date ==
                              DateTime.now().subtract(const Duration(days: 1))
                          ? widget.date.add(const Duration(days: 2))
                          : widget.date,
                      lastDate: DateTime(now.year, now.month, now.year + 1),
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
                      String formattedDate = formatDate.format(pickedDate);
                      setState(() {
                        datePicked = formattedDate;
                      });
                      widget.onDateChanged(pickedDate);
                    } else {}
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.icons.calendarPlus,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        datePicked,
                        style: AppTextStyles.normal16(),
                      ),
                    ],
                  ),
                ),
                if (widget.canSelectTime)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 1,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _selectTime,
                        child: Text(
                          dataTime,
                          style: AppTextStyles.normal16(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
