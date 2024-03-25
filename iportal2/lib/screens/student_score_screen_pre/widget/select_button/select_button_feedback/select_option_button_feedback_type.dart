import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/student_score_screen_pre/widget/select_button/select_button_feedback/bottom_sheet_select_feedback_type.dart';
import 'package:iportal2/resources/app_colors.dart';

import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class SelectFeedBackType extends StatefulWidget {
  const SelectFeedBackType({super.key, required this.onSelectedOptionChanged});
  final Function(String) onSelectedOptionChanged;
  @override
  State<SelectFeedBackType> createState() => _SelectFeedBackTypeState();
}

class _SelectFeedBackTypeState extends State<SelectFeedBackType> {
  String selectedOption = "Tuần 1";
  List<String> optionList = ["Tuần 1", "Tuần 2", "Tuần 3", "Tuần 4", "Tuần 5"];
  @override
  void initState() {
    super.initState();
    selectedOption = "Tuần 1";
  }

  void updateSelectedOption(String newOption) async {
    setState(() {
      selectedOption = newOption;
    });
    widget.onSelectedOptionChanged(newOption);
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showFlexibleBottomSheet(
          minHeight: 0,
          initHeight: 0.9,
          maxHeight: 1,
          context: context,
          builder: (
            BuildContext context,
            ScrollController scrollController,
            double bottomSheetOffset,
          ) =>
              BottomSheetSelectFeedBackType(
            optionList: optionList,
            scrollController: scrollController,
            onSelectedOption: updateSelectedOption,
            selectedOption: selectedOption,
          ),
          anchors: [0, 1],
          isSafeArea: true,
          bottomSheetBorderRadius: AppRadius.roundedTop16,
        )
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.gray,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icons/chevron-left.svg',
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.gray400, BlendMode.srcIn),
              ),
              Row(
                children: [
                  Text(
                    selectedOption,
                    style: AppTextStyles.semiBold14(
                      color: AppColors.brand600,
                    ),
                  ),
                  Text(
                    ' (4/3/2024 - 8/3/2024)',
                    style: AppTextStyles.normal14(
                      color: AppColors.black24,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.gray400, BlendMode.srcIn),
              )
            ],
          ),
        ),
      ),
    );
  }
}
