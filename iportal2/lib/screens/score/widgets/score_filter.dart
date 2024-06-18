import 'package:flutter/material.dart';
import 'package:iportal2/components/dropdown/dropdown.dart';
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

  void onUpdateTerm(String value) {
    final newParam = selectedOption.copyWith(
      selectedTerm: value,
      filterType: FilterType.term,
    );
    onSelectedOption(newParam);
  }

  void onUpdateScoreProgram(String value) {
    final newParam = selectedOption.copyWith(
      selectedScoreProgram: value,
      filterType: FilterType.program,
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
          DropdownButtonComponent(
            selectedOption: selectedOption.selectedScoreProgram,
            onUpdateOption: onUpdateScoreProgram,
            hint: 'Chọn chương trình học',
            optionList: programList,
          ),
          const SizedBox(height: 8),
          DropdownButtonComponent(
            selectedOption: selectedOption.selectedTerm,
            onUpdateOption: onUpdateTerm,
            hint: 'Chọn học kỳ',
            optionList: isPrimary
                ? PrimaryTermType.values.map((e) => e.text()).toList()
                : TermType.values.map((e) => e.text()).toList(),
          ),
        ],
      ),
    );
  }
}

class ListItem<T> {
  bool isSelected = false;
  final T data;

  ListItem(this.data, {this.isSelected = false});
}
