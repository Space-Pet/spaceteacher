import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/src/screens/student_score/widget/score_card_subject/score_subject_model.dart';

class CardCollapseScore extends StatelessWidget {
  const CardCollapseScore({
    super.key,
    this.isTimeTableView = false,
    required this.scoreCard,
  });

  final ScoreSubjectModel scoreCard;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.blueGray,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
