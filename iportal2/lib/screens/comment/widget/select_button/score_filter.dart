import 'package:flutter/material.dart';
import 'package:iportal2/components/dropdown/dropdown.dart';
import 'package:iportal2/screens/comment/bloc/comment_bloc.dart';
import 'package:iportal2/screens/comment/widget/tab_bar/tav_bar_view_report.dart';

class ListItem<T> {
  bool isSelected = false;
  final T data;

  ListItem(this.data, {this.isSelected = false});
}

class ScoreFilter extends StatefulWidget {
  const ScoreFilter({
    super.key,
    this.selectedOption,
    required this.onUpdateTerm,
  });

  final ViewScoreSelectedParam? selectedOption;
  final Function(String) onUpdateTerm;

  @override
  State<ScoreFilter> createState() => _ScoreFilterState();
}

class _ScoreFilterState extends State<ScoreFilter> {
  late ViewScoreSelectedParam selectedParam;

  @override
  void initState() {
    super.initState();
    initValueSelect();
  }

  void initValueSelect() {
    selectedParam = ViewScoreSelectedParam(
      selectedTerm: widget.selectedOption != null
          ? TermType.values
              .firstWhere((element) =>
                  element.getValue() == widget.selectedOption!.selectedTerm)
              .text()
          : TermType.term1.text(),
    );
  }

  void onUpdateTerm(String value) {
    final String updateValue =
        TermType.values.firstWhere((element) => element.text() == value).text();
    setState(() {
      selectedParam = selectedParam.copyWith(
        selectedTerm: updateValue,
      );
    });
    widget.onUpdateTerm(updateValue); // Gọi hàm callback onUpdateTerm
  }

  void onUpdateScoreType(String value) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonComponent(
          selectedOption: selectedParam.selectedTerm != ''
              ? selectedParam.selectedTerm
              : null,
          onUpdateOption: onUpdateTerm,
          hint: 'Chọn học kỳ',
          optionList: TermType.values.map((e) => e.text()).toList(),
        ),
      ],
    );
  }
}
