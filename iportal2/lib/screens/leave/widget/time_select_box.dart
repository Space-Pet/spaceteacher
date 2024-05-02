import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';

class TimeSelectBoxStart extends StatefulWidget {
  const TimeSelectBoxStart({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.onDateChanged,
    required this.onTimeChanged,
    this.dateStart,
    required this.helpText,
    this.canSelectTime = true,
  });

  final String title;
  final DateTime date;
  final DateTime? dateStart;
  final Function(DateTime) onDateChanged;
  final Function(DateTime) onTimeChanged;
  final TimeOfDay time;
  final String helpText;
  final bool canSelectTime;

  @override
  State<TimeSelectBoxStart> createState() => TimeSelectBoxStartState();
}

class TimeSelectBoxStartState extends State<TimeSelectBoxStart> {
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
                      initialDate: formatDate.parse(datePicked),
                      firstDate: DateTime(now.year, now.month, now.day - 1),
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
