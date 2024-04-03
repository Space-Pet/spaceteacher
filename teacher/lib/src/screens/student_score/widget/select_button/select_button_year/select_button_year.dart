import 'package:flutter/material.dart';
import 'package:teacher/src/screens/student_score/widget/select_button/select_button_year/select_option_button_year.dart';

class SelectYear extends StatefulWidget {
  const SelectYear({super.key});

  @override
  State<SelectYear> createState() => _SelectYearState();
}

class _SelectYearState extends State<SelectYear> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SelectPopupSheetYear();
  }
}
