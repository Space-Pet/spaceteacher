import 'package:core/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/tab_instruction.dart';
import 'package:teacher/src/utils/extension_context.dart';

import '../home/widgets/instruction_notebook/instruction_notebook_view.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const routeName = '/schedule';

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'schedule'.tr(),
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [
                  const SelectDate(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabInstruction(
                      lessons: lessons,
                      isTimeTableView: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          helpText: 'Chọn ngày',
          cancelText: 'Trở về',
          confirmText: 'Xong',
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
                        datePicked,
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
