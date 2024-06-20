import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class FieldRowCardDetail extends StatelessWidget {
  const FieldRowCardDetail({
    super.key,
    required this.title,
    required this.value,
    this.isLastItem = false,
    this.titleStyle,
    this.valueStyle,
  });

  final String title;
  final String value;
  final bool isLastItem;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: titleStyle ??
                  AppTextStyles.semiBold14(
                    color: AppColors.gray400,
                  ),
            ),
            const Spacer(),
            Flexible(
              flex: 3,
              child: AutoSizeText(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: valueStyle ??
                    AppTextStyles.semiBold12(
                      color: AppColors.gray500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (isLastItem == false) const DottedLine(dashColor: AppColors.gray300),
        if (isLastItem == false) const SizedBox(height: 10),
      ],
    );
  }
}
