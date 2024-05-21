import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:core/core.dart';
import 'package:teacher/src/screens/student_score/widget/score_card_subject/score_card_subject.dart';
import 'package:teacher/src/screens/student_score/widget/student_evaluation.dart';
import 'package:teacher/src/screens/student_score/widget/tabview/tab_bar_view_mid_term.dart';

class TabViewMonet extends StatefulWidget {
  const TabViewMonet({
    super.key,
  });
  @override
  State<TabViewMonet> createState() => _TabViewMonet();
}

class _TabViewMonet extends State<TabViewMonet> {
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
      Column(
        children: [
          const SizedBox(height: 18),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/document-medicine.svg',
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Điểm và nhận xét',
                style: AppTextStyles.bold16(color: AppColors.brand600),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 44,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Điểm trung bình môn',
                  style: AppTextStyles.normal14(color: AppColors.blueGray700),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '9.0',
                  style: AppTextStyles.bold18(color: AppColors.red),
                )
              ],
            ),
          )
        ],
      ),
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
                scoreSubjectList.length,
                (index) => CardScoreSubject(
                    isExpanded: expandedIndex == index,
                    index: index,
                    onExpansionChanged: () => _handleExpansion(index),
                    scoreCard: scoreSubjectList[index],
                    lastIndex: scoreSubjectList.length - 1))
          ],
        ),
      ),
      const StudentEvaluation()
    ]);
  }
}
