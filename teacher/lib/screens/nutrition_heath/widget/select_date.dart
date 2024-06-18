import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateNutrition extends StatefulWidget {
  const SelectDateNutrition(
      {super.key, this.onDatePicked, this.datePicked, this.selectDate});

  final Function(DateTime date)? onDatePicked;
  final DateTime? datePicked;
  final DateTime? selectDate;

  @override
  State<SelectDateNutrition> createState() => _SelectDateNutritionState();
}

class _SelectDateNutritionState extends State<SelectDateNutrition> {
  DateTime now = DateTime.now();
  DateFormat formatDate = DateFormat("MM/yyyy", 'vi_VN');
  late String datePickedFormat;

  @override
  void initState() {
    super.initState();
    if (widget.datePicked != null) {
      datePickedFormat = formatDate.format(widget.datePicked!);
    } else {
      datePickedFormat = formatDate.format(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime initialDate = widget.datePicked ?? DateTime.now();
        DateTime? pickedDate = await showModalBottomSheet<DateTime>(
          context: context,
          builder: (BuildContext context) {
            return _MonthYearPicker(
              initialDate: initialDate,
              onDatePicked: (date) {
                Navigator.of(context).pop(date);
              },
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = formatDate.format(pickedDate);
          setState(() {
            datePickedFormat = formattedDate;
          });
          widget.onDatePicked?.call(pickedDate);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.gray300),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        datePickedFormat,
                        style: AppTextStyles.normal16(color: AppColors.gray500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: AppColors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDatePicked;

  const _MonthYearPicker({
    required this.initialDate,
    required this.onDatePicked,
  });

  @override
  __MonthYearPickerState createState() => __MonthYearPickerState();
}

class __MonthYearPickerState extends State<_MonthYearPicker> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final months = List<String>.generate(
        12, (index) => DateFormat.MMMM().format(DateTime(0, index + 1)));
    final years =
        List<int>.generate(100, (index) => DateTime.now().year - 50 + index);

    return Container(
      height: 280,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedMonth - 1),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedMonth = index + 1;
                      });
                    },
                    children: months.map((month) => Text(month)).toList(),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: years.indexOf(selectedYear),
                    ),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedYear = years[index];
                      });
                    },
                    children:
                        years.map((year) => Text(year.toString())).toList(),
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            color: AppColors.red700,
            child: Text('Done'),
            onPressed: () {
              widget.onDatePicked(DateTime(selectedYear, selectedMonth));
            },
          ),
        ],
      ),
    );
  }
}
