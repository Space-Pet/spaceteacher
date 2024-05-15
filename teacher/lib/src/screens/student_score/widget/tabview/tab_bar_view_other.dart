import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/student_score/widget/score_card_other/score_card_subject_other.dart';
import 'package:teacher/src/screens/student_score/widget/tabview/tab_bar_view_mid_term.dart';

class TabViewOther extends StatefulWidget {
  const TabViewOther({
    super.key,
  });
  @override
  State<TabViewOther> createState() => _TabViewOther();
}

class _TabViewOther extends State<TabViewOther> {
  int? expandedIndex;
  void _handleExpansion(int index) {
    if (index == expandedIndex) {
      setState(() {
        expandedIndex = null;
      });
    } else {
      setState(() {
        expandedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 8,
      ),
      Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border(
              top: BorderSide(
                color: AppColors.gray300,
              ),
              left: BorderSide(
                color: AppColors.gray300,
              ),
              right: BorderSide(
                color: AppColors.gray300,
              ),
            )),
        child: Column(
          children: [
            ...List.generate(
                scoreSubjectListOther.length,
                (index) => CardScoreSubjectOther(
                    isExpanded: expandedIndex == index,
                    onExpansionChanged: () => _handleExpansion(index),
                    index: index,
                    scoreCard: scoreSubjectListOther[index],
                    lastIndex: scoreSubjectListOther.length - 1))
          ],
        ),
      ),
    ]);
  }
}
