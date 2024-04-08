import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_year/bottom_sheet_select_year.dart';

class SelectPopupSheetYear extends StatefulWidget {
  const SelectPopupSheetYear({
    super.key,
    required this.optionList,
    this.selectedOption,
    this.handleSelectedOptionChanged,
  });

  final List<String> optionList;
  final ViewScoreSelectedParam? selectedOption;
  final void Function(ViewScoreSelectedParam)? handleSelectedOptionChanged;

  @override
  State<SelectPopupSheetYear> createState() => _SelectPopupSheetYearState();
}

class _SelectPopupSheetYearState extends State<SelectPopupSheetYear> {
  @override
  void initState() {
    super.initState();
  }

  void updateSelectedOption(ViewScoreSelectedParam newOption) async {
    widget.handleSelectedOptionChanged?.call(newOption);
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
              BottomSheetSelectYear(
            optionList: widget.optionList,
            scrollController: scrollController,
            onSelectedOption: updateSelectedOption,
            selectedOption: widget.selectedOption,
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
                'Lọc',
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
