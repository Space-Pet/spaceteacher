import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, required this.onDateChanged});

  final Function(DateTime date) onDateChanged;

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
          widget.onDateChanged(pickedDate);
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
            side: const BorderSide(color: AppColors.blueGray100),
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

class SelectField extends StatefulWidget {
  const SelectField({required this.typeField, super.key});
  final int typeField;
  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  String _selected = 'Select Field';
  String _hintText = '';
  @override
  void initState() {
    switch (widget.typeField) {
      case 1:
        _hintText = 'Chọn';
        break;
      case 2:
        _hintText = 'Tên giáo viên';
        break;
      case 3:
        _hintText = 'Tiết học';
        break;
      case 4:
        _hintText = 'Lớp';
        break;
      default:
        _hintText = 'Chọn';
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 24,
        color: AppColors.gray900,
      ),
      focusColor: AppColors.blueGray100,

      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        focusColor: AppColors.blueGray100,
        fillColor: AppColors.blueGray100,
        hintText: _hintText,
      ),
      // value: _selected,
      hint: Text(_hintText,
          style: AppTextStyles.normal16(color: AppColors.gray500)),
      onChanged: (String? value) {
        setState(() {
          _selected = value!;
        });
      },
      items: <String>['Select Field', 'Field 1', 'Field 2', 'Field 3']
          .map<DropdownMenuItem<String>>((String? value) {
        return DropdownMenuItem<String>(
          value: value ?? "",
          child: Text(value ?? ""),
        );
      }).toList(),
    );
  }
}
