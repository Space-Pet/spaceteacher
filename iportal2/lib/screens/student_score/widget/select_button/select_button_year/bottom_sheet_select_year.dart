import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/components/dropdown/dropdown.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_year/select_option_button_year.dart';

// Step 1: Define a model for list items
class ListItem<T> {
  bool isSelected = false;
  final T data;

  ListItem(this.data, {this.isSelected = false});
}

class BottomSheetSelectYear extends StatefulWidget {
  const BottomSheetSelectYear({
    super.key,
    required this.scrollController,
    required this.onSelectedOption,
    required this.optionList,
    this.selectedOption,
  });

  final ScrollController scrollController;
  final ViewScoreSelectedParam? selectedOption;
  final List<String> optionList;
  final void Function(ViewScoreSelectedParam) onSelectedOption;

  @override
  State<BottomSheetSelectYear> createState() => _BottomSheetSelectYearState();
}

class _BottomSheetSelectYearState extends State<BottomSheetSelectYear> {
  String selectedYear = '';
  String selectedTerm = '';
  String selectedScoreType = '';

  @override
  void initState() {
    super.initState();
    selectedYear = widget.selectedOption != null
        ? widget.selectedOption!.selectedYear
        : '';
    selectedTerm = widget.selectedOption != null
        ? TermType.values
            .firstWhere((element) =>
                element.getValue() == widget.selectedOption!.selectedTerm)
            .text()
        : TermType.term1.text();
    selectedScoreType = widget.selectedOption != null
        ? widget.selectedOption!.selectedScoreType
        : 'MOET';
  }

  void onSelectedOptionBottom() {
    if (TermType.values
        .map((e) => e.getValue())
        .toList()
        .contains(selectedTerm)) {
      ViewScoreSelectedParam selectedParam = ViewScoreSelectedParam(
          selectedYear: selectedYear,
          selectedScoreType: selectedScoreType,
          selectedTerm: selectedTerm);
      print('select parram 1 $selectedParam');
      widget.onSelectedOption(selectedParam);
    } else {
      ViewScoreSelectedParam selectedParam = ViewScoreSelectedParam(
          selectedYear: selectedYear,
          selectedScoreType: selectedScoreType,
          selectedTerm: TermType.values
              .firstWhere((element) => element.text() == selectedTerm)
              .getValue());
      print('select parram 2 $selectedParam');
      widget.onSelectedOption(selectedParam);
    }
  }

  void onUpdateYear(String value) {
    print('year $value');
    setState(() {
      selectedYear = value;
    });
  }

  void onUpdateTerm(String value) {
    final String updateValue = TermType.values
        .firstWhere((element) => element.text() == value)
        .getValue();
    print('Term value $updateValue');
    setState(() {
      selectedTerm = updateValue;
    });
  }

  void onUpdateScoreType(String value) {
    print('Type $value');
    setState(() {
      selectedScoreType = value;
    });
  }

  void unSelectOption() {}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bộ lọc',
                  style: AppTextStyles.bold18(color: AppColors.black24),
                ),
                RoundedButton(
                  onTap: unSelectOption,
                  padding: const EdgeInsets.all(0),
                  buttonColor: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/icons/reset.svg',
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 83, 83, 83), BlendMode.srcIn),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chương trình học',
                  style: AppTextStyles.semiBold16(color: AppColors.gray700),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonComponent(
                    selectedOption:
                        selectedScoreType != '' ? selectedScoreType : null,
                    onUpdateOption: onUpdateScoreType,
                    onUnselectOption: unSelectOption,
                    hint: 'Chọn chương trình học',
                    optionList: ScoreType.values.map((e) => e.text()).toList(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Năm học',
                  style: AppTextStyles.semiBold16(color: AppColors.gray700),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonComponent(
                    selectedOption: selectedYear != '' ? selectedYear : null,
                    onUpdateOption: onUpdateYear,
                    onUnselectOption: unSelectOption,
                    hint: 'Chọn năm học',
                    optionList: widget.optionList,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Học kỳ',
                  style: AppTextStyles.semiBold16(color: AppColors.gray700),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonComponent(
                    selectedOption: selectedTerm != '' ? selectedTerm : null,
                    onUpdateOption: onUpdateTerm,
                    onUnselectOption: unSelectOption,
                    hint: 'Chọn học kỳ',
                    optionList: TermType.values.map((e) => e.text()).toList(),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 44,
              child: RoundedButton(
                onTap: onSelectedOptionBottom,
                borderRadius: 70,
                padding: EdgeInsets.zero,
                buttonColor: AppColors.red90001,
                child: Text(
                  'Áp dụng',
                  style: AppTextStyles.semiBold16(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
