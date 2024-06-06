import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  const SelectDate(
      {super.key, this.onDatePicked, this.datePicked, this.selectDate});

  final Function(DateTime date)? onDatePicked;
  final DateTime? datePicked;
  final DateTime? selectDate;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat('EEEE, dd/MM/yyyy', 'vi_VN');
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
    return Container(
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
                      DateFormat('dd/MM/yyyy')
                          .format(widget.selectDate ?? DateTime.now()),
                      style: AppTextStyles.normal16(color: AppColors.gray500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
