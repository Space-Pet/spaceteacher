import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/resources/app_colors.dart';
import 'package:core/resources/assets.gen.dart';

class RowContent extends StatelessWidget {
  const RowContent({
    super.key,
    required this.title,
    required this.content,
    this.isHighlightContent = false,
    this.isEditPhone = false,
    this.isShowDottedLine = true,
    this.onTap,
    this.formSize,
  });
  final String title;
  final String content;
  final bool isEditPhone;
  final bool isHighlightContent;
  final Function()? onTap;
  final bool isShowDottedLine;
  final double? formSize;

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
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: formSize ?? 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Text(
                        content,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: isHighlightContent
                                ? AppColors.blue500
                                : AppColors.gray500,
                            fontSize: formSize ?? 12,
                            fontWeight: isHighlightContent
                                ? FontWeight.w600
                                : FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              if (isEditPhone)
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      Assets.icons.editProfile,
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
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
