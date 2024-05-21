import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/leave_model.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup({
    super.key,
    required this.content,
    required this.title,
    this.color,
  });

  final String title;
  final String content;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.normal14(
              color: AppColors.gray600, fontWeight: FontWeight.w400),
        ),
        Text(
          content,
          style: AppTextStyles.normal14(
              color: color ?? AppColors.gray500, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
