import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class FeedbackGroup extends StatelessWidget {
  const FeedbackGroup({super.key,  this.comment});
  final Comment? comment;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.deepOrangeBg,
        borderRadius: AppRadius.roundedTop16,
      ),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bold-note-document.svg',
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.redMenu, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Nhận xét của giáo viên',
                style: AppTextStyles.semiBold16(
                  color: AppColors.brand600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.rounded14,
                border: Border.all(color: AppColors.red900)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/conversation-icon.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                      AppColors.redMenu, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                Expanded(
                  // Wrap the Text widget with Expanded
                  child: Text(
                    comment?.commentNote ?? '',
                    style: AppTextStyles.normal12(
                      color: AppColors.gray700,
                    ),
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'GV: Nguyễn Huỳnh Vi Khương',
            style: AppTextStyles.normal12(
              color: AppColors.gray800,
            ),
          ),
        ],
      ),
    );
  }
}
