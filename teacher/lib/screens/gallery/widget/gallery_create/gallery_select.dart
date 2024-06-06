import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GallerySelect extends StatefulWidget {
  final List<String> optionList;
  final String label;
  final String? selectedOption;
  final void Function(String) onUpdateOption;
  final bool isLoading;

  const GallerySelect({
    super.key,
    required this.optionList,
    required this.label,
    required this.onUpdateOption,
    this.selectedOption,
    this.isLoading = false,
  });

  @override
  State<GallerySelect> createState() => _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<GallerySelect> {
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
  didUpdateWidget(GallerySelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOption != oldWidget.selectedOption) {
      setState(() {
        dropdownValue = widget.selectedOption;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != '')
          Text(
            widget.label,
            style: AppTextStyles.semiBold16(color: AppColors.gray700),
          ),
        const SizedBox(height: 4),
        AppSkeleton(
          isLoading: widget.isLoading,
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.gray300,
              ),
            ),
            child: DropdownButton<String>(
              focusNode: _focusNode,
              isExpanded: true,
              value: dropdownValue,
              dropdownColor: AppColors.white,
              isDense: false,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.gray600,
                size: 28,
              ),
              onTap: () {
                if (widget.optionList.length > 1) {
                  setState(() {
                    isOpenDropDown = true;
                  });
                }
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onChanged: (String? value) {
                if (value != null) {
                  updateSelectedOption(value, false);
                }
              },
              padding: const EdgeInsets.fromLTRB(12, 4, 8, 4),
              style: AppTextStyles.semiBold14(color: AppColors.gray500),
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
              items: widget.optionList
                  .map<DropdownMenuItem<String>>((String value) {
                return value == 'Chọn lớp'
                    ? DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                            widget.optionList.length > 1
                                ? value
                                : 'Không có lớp nào để chọn, vui lòng chọn năm học khác!',
                            style: AppTextStyles.semiBold16(
                                color: AppColors.gray600)),
                      )
                    : DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value,
                                  style: AppTextStyles.semiBold14(
                                      color: AppColors.brand600)),
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
                        ),
                      );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
