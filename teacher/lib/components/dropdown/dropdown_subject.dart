import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DropdownSelectSubject extends StatefulWidget {
  final List<String> optionList;
  final String hint;
  final String? selectedOption;
  final void Function(String) onUpdateOption;

  const DropdownSelectSubject({
    super.key,
    required this.optionList,
    required this.hint,
    required this.onUpdateOption,
    this.selectedOption,
  });

  @override
  State<DropdownSelectSubject> createState() => _DropdownSelectSubjectState();
}

class _DropdownSelectSubjectState extends State<DropdownSelectSubject> {
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
  didUpdateWidget(DropdownSelectSubject oldWidget) {
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
        color: AppColors.white,
        border: Border.all(
          color: AppColors.gray100,
        ),
      ),
      child: DropdownButton<String>(
        hint: Text(
          widget.hint,
          style: AppTextStyles.normal16(),
        ),
        focusNode: _focusNode,
        isExpanded: true,
        value: dropdownValue,
        isDense: true,
        icon: SvgPicture.asset(
          'assets/icons/chevron-down.svg',
          height: 20,
          width: 20,
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
        padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
        style: AppTextStyles.semiBold14(color: AppColors.black24),
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
