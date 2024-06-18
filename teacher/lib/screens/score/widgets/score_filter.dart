import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';

class ScoreFilter extends StatelessWidget {
  const ScoreFilter({
    super.key,
    required this.onSelectedOption,
    required this.selectedOption,
    required this.isPrimary,
    required this.semesterList,
  });

  final bool isPrimary;
  final ViewScoreSelectedParam selectedOption;
  final void Function(ViewScoreSelectedParam) onSelectedOption;
  final List<Semester> semesterList; // Add this line to accept semester list

  void onUpdateTerm(Semester semester) {
    final newParam = selectedOption.copyWith(
      selectedTerm: semester.title,
      valueTerm: semester.value,
    );
    onSelectedOption(newParam);
    print(semester.value); // Print the value of the selected semester
  }

  void onUpdateScoreType(String value) {
    final newParam = selectedOption.copyWith(
      selectedScoreType: value,
    );
    onSelectedOption(newParam);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure no duplicates in the optionList
    final uniqueSemesterNames =
        semesterList.map((e) => e.title).toSet().toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonComponent(
            selectedOption: selectedOption.selectedScoreType,
            onUpdateOption: onUpdateScoreType,
            hint: 'Chọn chương trình học',
            optionList: ScoreType.values.map((e) => e.text()).toList(),
          ),
          const SizedBox(height: 8),
          DropdownButtonComponent(
            selectedOption: selectedOption.selectedTerm,
            onUpdateOption: (value) {
              final selectedSemester = semesterList
                  .firstWhere((semester) => semester.title == value);
              onUpdateTerm(selectedSemester);
            },
            hint: 'Chọn học kỳ',
            optionList: uniqueSemesterNames, // Use unique names
          ),
        ],
      ),
    );
  }
}
