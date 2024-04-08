import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';

class DropdownButtonComponent extends StatefulWidget {
  final List<String> optionList;
  final String hint;
  final String? selectedOption;
  final void Function() onUnselectOption;
  final void Function(String) onUpdateOption;

  const DropdownButtonComponent({
    super.key,
    required this.optionList,
    required this.hint,
    required this.onUnselectOption,
    required this.onUpdateOption,
    this.selectedOption,
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

  void unSelect() async {
    setState(() {
      dropdownValue = '';
    });
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFEAECF0),
        ),
      ),
      child: DropdownButton<String>(
        hint: Text(
          widget.hint,
          style: AppTextStyles.normal16(color: AppColors.gray300),
        ),
        focusNode: _focusNode,
        isExpanded: true,
        value: dropdownValue,
        isDense: true,
        icon: SvgPicture.asset(
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
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        style: const TextStyle(
          color: Color(0xFF424242),
          fontSize: 16,
        ),
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
                Text(value),
                Radio(
                  activeColor: AppColors.green400,
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
