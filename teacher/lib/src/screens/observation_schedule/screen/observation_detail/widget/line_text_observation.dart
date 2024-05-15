import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class LineTextObservationDetail extends StatelessWidget {
  const LineTextObservationDetail({
    required this.title,
    required this.value,
    required this.isFirstLine,
    this.isLastLine = false,
    super.key,
  });

  final String title;
  final String value;
  final bool isFirstLine;
  final bool isLastLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isLastLine
                    ? AppTextStyles.normal18()
                    : AppTextStyles.normal16(),
              ),
              Text(
                value,
                style: AppTextStyles.bold16(
                  color: isFirstLine
                      ? AppColors.observationJoinText
                      : AppColors.gray600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (!isLastLine)
            const DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 1,
              dashColor: AppColors.gray400,
              dashRadius: 0.0,
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
        ],
      ),
    );
  }
}
