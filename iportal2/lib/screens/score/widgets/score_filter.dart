import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/bottom_sheet/select_bottom_sheet.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/score_screen.dart';

class ScoreFilter extends StatelessWidget {
  const ScoreFilter({
    super.key,
    required this.onSelectedOption,
    required this.selectedOption,
    required this.isPrimary,
    required this.programList,
  });

  final bool isPrimary;
  final ViewScoreSelectedParam selectedOption;
  final void Function(ViewScoreSelectedParam) onSelectedOption;
  final List<String> programList;

  void onUpdateOption(String value, FilterType filterType) {
    ViewScoreSelectedParam newParam = selectedOption;
    final isUpdateProgram = filterType == FilterType.program;
    newParam = selectedOption.copyWith(
      filterType: filterType,
      selectedTerm: isUpdateProgram ? selectedOption.selectedTerm : value,
      selectedScoreProgram:
          isUpdateProgram ? value : selectedOption.selectedScoreProgram,
    );
    onSelectedOption(newParam);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterItem(
              title: 'Chọn chương trình học',
              options: programList,
              selectedOption: selectedOption.selectedScoreProgram,
              onUpdateOption: (value) =>
                  onUpdateOption(value, FilterType.program)),
          const SizedBox(height: 8),
          FilterItem(
              title: 'Chọn học kỳ',
              options: isPrimary
                  ? PrimaryTermType.values.map((e) => e.text()).toList()
                  : TermType.values.map((e) => e.text()).toList(),
              selectedOption: selectedOption.selectedTerm,
              onUpdateOption: (value) =>
                  onUpdateOption(value, FilterType.term)),
        ],
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.title,
    required this.options,
    required this.onUpdateOption,
    this.selectedOption,
    this.width,
    this.hintText = 'Chọn',
    this.isTransparentStyle = false,
  });

  final String title;
  final List<String> options;
  final String? selectedOption;
  final double? width;
  final String hintText;
  final void Function(String) onUpdateOption;
  final bool isTransparentStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => SelectBottomSheet(
            title: title,
            options: options,
            selectedOption: selectedOption,
            onUpdateOption: onUpdateOption,
          ),
        );
      },
      child: Container(
        width: width ?? double.infinity,
        padding: isTransparentStyle
            ? const EdgeInsets.fromLTRB(12, 2, 4, 2)
            : const EdgeInsets.fromLTRB(20, 4, 14, 4),
        decoration: BoxDecoration(
          color: isTransparentStyle ? Colors.transparent : AppColors.gray100,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isTransparentStyle ? AppColors.gray100 : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedOption ?? hintText,
                style: AppTextStyles.semiBold14(
                  color:
                      isTransparentStyle ? AppColors.white : AppColors.brand600,
                )),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isTransparentStyle ? AppColors.white : AppColors.gray400,
              size: 32,
            )
          ],
        ),
      ),
    );
  }
}
