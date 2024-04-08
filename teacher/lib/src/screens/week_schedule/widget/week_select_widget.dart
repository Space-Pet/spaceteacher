import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/resources.dart';

class WeekSelectWidget extends StatefulWidget {
  const WeekSelectWidget({super.key});

  @override
  State<WeekSelectWidget> createState() => _WeekSelectWidgetState();
}

class _WeekSelectWidgetState extends State<WeekSelectWidget> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  int _currentWeek = 1;
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(DateTime.now());
  }

  void _goBackOneWeek() {
    setState(() {
      if (_currentWeek >= 1) {
        now = now.subtract(const Duration(days: 7));
        _currentWeek--;
      } else {
        return;
      }
    });
  }

  void _goForwardOneWeek() {
    setState(() {
      _currentWeek++;
      now = now.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 4));

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
                onTap: _goBackOneWeek,
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
                      helpText: 'select date'.tr(),
                      cancelText: 'cancel'.tr(),
                      confirmText: 'confirm'.tr(),
                      initialDate: formatDate.parse(datePicked),
                      firstDate: DateTime(now.year, now.month, now.day - 7),
                      lastDate: DateTime(now.year, now.month, now.day + 7),
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
                    } else {}
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tuần $_currentWeek ',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600)),
                      Text(
                        '(${DateFormat('dd/M/yyyy').format(startOfWeek)} -  ${DateFormat('dd/M/yyyy').format(endOfWeek)})',
                        style: AppTextStyles.normal14(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _goForwardOneWeek,
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
