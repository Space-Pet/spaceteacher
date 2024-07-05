import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';

class ScoreFilter extends StatelessWidget {
  const ScoreFilter({
    super.key,
    required this.state,
    required this.onSelectedOption,
    required this.selectedOption,
    required this.semesterList,
    required this.programList, // Accept programList in constructor
  });

  final ViewScoreSelectedParam selectedOption;
  final void Function(ViewScoreSelectedParam) onSelectedOption;
  final List<Semester> semesterList;
  final List<ScoreProgram> programList;
  final ScoreState state;

  void onUpdateTerm(Semester semester) {
    final newParam = selectedOption.copyWith(
      selectedTerm: semester.title,
      valueTerm: semester.value,
      selectedScoreType: state.isMOET
    );
    onSelectedOption(newParam);
    print(semester.value);
  }

  void onUpdateScoreType(ScoreProgram value) {
    final newParam = selectedOption.copyWith(
      selectedScoreType: value.ctName,
      valueTerm: state.termType,
    );
    onSelectedOption(newParam);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure no duplicates in the optionList
    final uniqueSemesterNames =
        semesterList.map((e) => e.title).toSet().toList();
    final uniqueProgramNames =
        programList.map((e) => e.ctName).toSet().toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonComponent(
            selectedOption: selectedOption.selectedScoreType,
            onUpdateOption: (value) {
              final selectProgram =
                  programList.firstWhere((test) => test.ctName == value);
              onUpdateScoreType(selectProgram);
            },
            hint: 'Chọn chương trình học',
            optionList:
                uniqueProgramNames, // Use programList instead of ScoreType
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
