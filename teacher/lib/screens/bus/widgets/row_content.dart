import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class RowContentBus extends StatelessWidget {
  const RowContentBus({
    super.key,
    required this.title,
    required this.content,
    this.isShowDottedLine = true,
    this.color,
  });
  final String title;
  final String content;
  final Color? color;
  final bool isShowDottedLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.normal14(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        content,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.normal14(
                          color: color ?? AppColors.gray600,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isShowDottedLine)
            const DottedLine(
              dashLength: 2,
              dashColor: AppColors.gray300,
            ),
        ],
      ),
    );
  }
}
