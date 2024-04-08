import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_term/bottom_sheet_select_term.dart';

class SelectTerm extends StatefulWidget {
  const SelectTerm({super.key, required this.onSelectedOptionChanged});
  final Function(String) onSelectedOptionChanged;
  @override
  State<SelectTerm> createState() => _SelectTermState();
}

class _SelectTermState extends State<SelectTerm> {
  String selectedOption = "Học kỳ 2";
  List<String> optionList = ["Học kỳ 1", "Học kỳ 2"];

  @override
  void initState() {
    super.initState();
    selectedOption = "Học kỳ 2";
  }

  void updateSelectedOption(String newOption) async {
    widget.onSelectedOptionChanged(newOption);
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
              BottomSheetSelectTerm(
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
