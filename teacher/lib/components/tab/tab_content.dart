import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowContent extends StatelessWidget {
  const RowContent({
    super.key,
    required this.title,
    required this.content,
    this.isShowDottedLine = true,
  });
  final String title;
  final String content;
  final bool isShowDottedLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray500,
                          )),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Text(
                        content,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.normal14(
                          color: AppColors.gray500,
                        ),
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
