import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class DropdownButtonComponent extends StatefulWidget {
  final List<String> optionList;
  final String hint;
  final String? selectedOption;
  final bool isSelectYear;
  final void Function(String) onUpdateOption;

  const DropdownButtonComponent({
    super.key,
    required this.optionList,
    required this.hint,
    required this.onUpdateOption,
    this.selectedOption,
    this.isSelectYear = false,
  });

  @override
  State<DropdownButtonComponent> createState() =>
      _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<DropdownButtonComponent> {
  String? dropdownValue;
  bool isOpenDropDown = false;
  final FocusNode _focusNode = FocusNode();

  void updateSelectedOption(String value, bool isClose) async {
    setState(() {
      dropdownValue = value;
      isOpenDropDown = false;
    });
    widget.onUpdateOption(value);

    if (isClose) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedOption != null) {
      dropdownValue = widget.selectedOption;
    }

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isOpenDropDown = false;
        });
      }
    });
  }

  @override
  didUpdateWidget(DropdownButtonComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOption != oldWidget.selectedOption) {
      setState(() {
        dropdownValue = widget.selectedOption;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: widget.isSelectYear ? Colors.transparent : AppColors.gray100,
        border: Border.all(
          color: AppColors.gray100,
        ),
      ),
      child: DropdownButton<String>(
        hint: Text(
          widget.hint,
          style: AppTextStyles.normal16(color: AppColors.brand600),
        ),
        focusNode: _focusNode,
        isExpanded: true,
        value: dropdownValue,
        isDense: true,
        icon: widget.isSelectYear
            ? const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.white,
                size: 24,
              )
            : SvgPicture.asset(
                'assets/icons/chevron-down.svg',
                height: 24,
                width: 24,
              ),
        onTap: () {
          setState(() {
            isOpenDropDown = true;
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onChanged: (String? value) {
          if (value != null) {
            updateSelectedOption(value, false);
          }
        },
        padding: widget.isSelectYear
            ? const EdgeInsets.fromLTRB(12, 4, 8, 4)
            : const EdgeInsets.fromLTRB(20, 8, 16, 8),
        style: AppTextStyles.semiBold14(
            color: widget.isSelectYear ? AppColors.white : AppColors.brand600),
        underline: Container(
          color: Colors.transparent,
        ),
        selectedItemBuilder: (BuildContext context) {
          return widget.optionList.map<Widget>((String value) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
              ],
            );
          }).toList();
        },
        items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: AppTextStyles.semiBold14(color: AppColors.brand600)),
                Radio(
                  activeColor: AppColors.brand600,
                  value: value,
                  groupValue: dropdownValue,
                  onChanged: (String? value) {
                    if (value != null) {
                      updateSelectedOption(value, true);
                    }
                  },
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
