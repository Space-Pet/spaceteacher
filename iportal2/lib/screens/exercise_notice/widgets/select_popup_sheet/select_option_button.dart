import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';

import 'package:iportal2/screens/exercise_notice/widgets/select_popup_sheet/bottom_sheet_select.dart';
import 'package:iportal2/resources/app_colors.dart';

import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class SelectPopupSheet extends StatefulWidget {
  const SelectPopupSheet(
      {super.key,
      required this.onSelectedOptionChanged,
      required this.optionList});
  final Function(String) onSelectedOptionChanged;
  final List<String> optionList;

  @override
  State<SelectPopupSheet> createState() => _SelectPopupSheetState();
}

class _SelectPopupSheetState extends State<SelectPopupSheet> {
  String selectedOption = SubjectType.all.text();
  @override
  void initState() {
    super.initState();
    selectedOption = SubjectType.all.text();
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
              BottomSheetSelect(
            optionList: widget.optionList,
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
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.blueGray100),
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedOption,
                style: AppTextStyles.normal14(
                  color: AppColors.black24,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              SvgPicture.asset(
                'assets/icons/chevron-down.svg',
                height: 12,
                width: 12,
                // colorFilter:
                //     const ColorFilter.mode(AppColors.gray400, BlendMode.srcIn),
              )
            ],
          ),
        ),
      ),
    );
  }
}
