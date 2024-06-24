import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class StudentEvaluationItem extends StatelessWidget {
  const StudentEvaluationItem({
    super.key,
    required this.label,
    required this.result,
    this.isLast = false,
    required this.isBoldTitle,
  });
  final String label;
  final String result;
  final bool isLast;
  final bool isBoldTitle;

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
          Text(label,
              style: AppTextStyles.normal14(
                color: AppColors.gray600,
                fontWeight: isBoldTitle ? FontWeight.w600 : FontWeight.normal,
              )),
          Text(
            result,
            style: AppTextStyles.bold14(color: AppColors.brand600),
          )
        ],
      ),
    );
  }
}
