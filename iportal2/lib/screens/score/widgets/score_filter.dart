import 'package:core/presentation/common_widget/filter_select.dart';
import 'package:flutter/material.dart';
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
