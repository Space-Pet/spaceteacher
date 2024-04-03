import 'package:flutter/material.dart';

import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/resources/app_text_styles.dart';
import 'package:teacher/src/screens/student_score/widget/select_button/select_button_year/select_button_year.dart';

class ScreenAppBar extends StatelessWidget {
  final String title;
  final bool canGoback;
  final bool hasUpdateYear;
  final VoidCallback? onBack;

  const ScreenAppBar({
    super.key,
    this.onBack,
    this.hasUpdateYear = false,
    required this.title,
    this.canGoback = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        mainAxisAlignment: hasUpdateYear
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          if (canGoback)
            Row(
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          Text(title, style: AppTextStyles.semiBold18(color: AppColors.white)),
          if (hasUpdateYear) const SelectYear()
        ],
      ),
    );
  }
}
