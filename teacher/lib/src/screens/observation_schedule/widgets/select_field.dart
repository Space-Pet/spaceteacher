import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class SelectDate extends StatefulWidget {
  const SelectDate(
      {super.key, required this.onDateChanged, this.isHideIcon = false});

  final Function(DateTime date) onDateChanged;
  final bool isHideIcon;

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
                  if (!widget.isHideIcon)
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: AppColors.gray500,
                    ),
                  if (!widget.isHideIcon) const SizedBox(width: 8),
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
            if (!widget.isHideIcon)
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

class SelectPercent extends StatefulWidget {
  const SelectPercent(
      {super.key, required this.onPercentChanged, required this.hintText});

  final Function(String percent) onPercentChanged;
  final String hintText;

  @override
  State<SelectPercent> createState() => _SelectPercentState();
}

class _SelectPercentState extends State<SelectPercent> {
  String percentSelected = '';

  @override
  void initState() {
    super.initState();
  }

  final List<String> listPercent = [
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%',
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? pickedPercent = await showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) {
            return Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: AppColors.gray100,
                        ),
                        child: Text(
                          widget.hintText,
                          style: AppTextStyles.bold16(
                              color: AppColors.blueForgorPassword),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: listPercent.map(
                          (String value) {
                            return RadioListTile<String>(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              title: Text(value),
                              value: value,
                              groupValue: percentSelected,
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: AppColors.blueForgorPassword,
                              onChanged: (newValue) {
                                setState(() {
                                  percentSelected = newValue!;
                                  context.pop(result: newValue);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        if (pickedPercent != null) {
          widget.onPercentChanged(pickedPercent);
          setState(() {
            percentSelected = pickedPercent;
          });
        }
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                isNullOrEmpty(percentSelected)
                    ? widget.hintText
                    : percentSelected,
                style: AppTextStyles.normal16(color: AppColors.gray500),
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

class SelectFiledRadio extends StatefulWidget {
  const SelectFiledRadio(
      {super.key,
      required this.onValueChanged,
      required this.data,
      required this.hintText});

  final Function(String value) onValueChanged;
  final String hintText;
  final List<String> data;

  @override
  State<SelectFiledRadio> createState() => _SelectFiledRadioState();
}

class _SelectFiledRadioState extends State<SelectFiledRadio> {
  String selected = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? selectedData = await showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) {
            return Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: AppColors.gray100,
                        ),
                        child: Text(
                          widget.hintText,
                          style: AppTextStyles.bold16(
                              color: AppColors.blueForgorPassword),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.data.map(
                          (String value) {
                            return RadioListTile<String>.adaptive(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              title: Text(value),
                              value: value,
                              groupValue: selected,
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: AppColors.blueForgorPassword,
                              onChanged: (newValue) {
                                setState(() {
                                  selected = newValue!;
                                  context.pop(result: newValue);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        if (selectedData != null) {
          widget.onValueChanged(selectedData);
          setState(() {
            selected = selectedData;
          });
        }
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                isNullOrEmpty(selected) ? widget.hintText : selected,
                style: AppTextStyles.normal16(color: AppColors.gray500),
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
