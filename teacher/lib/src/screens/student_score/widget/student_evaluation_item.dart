import 'package:flutter/material.dart';

import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/resources/app_text_styles.dart';

class StudentEvaluationItem extends StatelessWidget {
  const StudentEvaluationItem({
    super.key,
    required this.label,
    required this.result,
    this.isLast = false,
  });
  final String label;
  final String result;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
          border: isLast
              ? Border.all(color: Colors.transparent)
              : const Border(bottom: BorderSide(color: AppColors.gray300))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.normal14(color: AppColors.gray600)),
          Text(
            result,
            style: AppTextStyles.bold14(color: AppColors.brand600),
          )
        ],
      ),
    );
  }
}
