import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:iportal2/screens/exercise_notice/widgets/select_popup_sheet/bottom_sheet_select.dart';
import 'package:iportal2/resources/app_colors.dart';

import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class SelectPopupSheetYear extends StatefulWidget {
  const SelectPopupSheetYear({
    super.key,
  });

  @override
  State<SelectPopupSheetYear> createState() => _SelectPopupSheetYearState();
}

class _SelectPopupSheetYearState extends State<SelectPopupSheetYear> {
  String selectedOption = "Năm học: 2023 - 2024";
  List<String> optionList = ["Năm học: 2023 - 2024", "Năm học: 2024 - 2025"];
  @override
  void initState() {
    super.initState();
    selectedOption = "Năm học: 2023 - 2024";
  }

  void updateSelectedOption(String newOption) async {
    setState(() {
      selectedOption = newOption;
    });
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
              BottomSheetSelect(
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
            color: Colors.transparent,
            border: Border.all(color: AppColors.white)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedOption,
                style: AppTextStyles.semiBold14(
                  color: AppColors.white,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-down.svg',
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
              )
            ],
          ),
        ),
      ),
    );
  }
}
