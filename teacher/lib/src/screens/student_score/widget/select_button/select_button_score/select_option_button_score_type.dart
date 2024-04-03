import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/resources/app_decoration.dart';
import 'package:teacher/resources/app_text_styles.dart';
import 'package:teacher/src/screens/student_score/widget/select_button/select_button_score/bottom_sheet_select_score_type.dart';

class SelectScoreType extends StatefulWidget {
  const SelectScoreType({super.key, required this.onSelectedOptionChanged});
  final Function(String) onSelectedOptionChanged;
  @override
  State<SelectScoreType> createState() => _SelectScoreTypeState();
}

class _SelectScoreTypeState extends State<SelectScoreType> {
  String selectedOption = "Điểm MOET";
  List<String> optionList = ["Điểm MOET", "Điểm chương trình khác"];
  @override
  void initState() {
    super.initState();
    selectedOption = "Điểm MOET";
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
              BottomSheetSelectScoreType(
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
              Text(
                selectedOption,
                style: AppTextStyles.semiBold14(
                  color: AppColors.brand600,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-down.svg',
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
