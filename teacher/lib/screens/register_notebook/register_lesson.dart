import 'package:core/data/models/weeky_lesson.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/components/dialog/dialog_view_exercise.dart';

class RegisterItem extends StatelessWidget {
  const RegisterItem({
    super.key,
    required this.lesson,
    required this.noBoder,
  });

  final Data lesson;
  final bool noBoder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        border: Border(
          bottom: noBoder
              ? BorderSide.none
              : const BorderSide(color: AppColors.gray300),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 6),
            width: 110.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tiết ${lesson.tietNum}',
                  style: AppTextStyles.normal14(color: AppColors.black24),
                ),
                const SizedBox(height: 4),
                if ((lesson.danDoBaoBai ?? '').isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DialogViewExercise(
                          title: 'Nhận xét',
                          content: lesson.lessonNote ?? '',
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/advice.svg'),
                        const SizedBox(width: 4),
                        Text(
                          'Nhận xét',
                          style:
                              AppTextStyles.normal14(color: AppColors.black24),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 64,
                  decoration: BoxDecoration(
                      color: AppColors.brand600,
                      borderRadius: BorderRadius.circular(14)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.subjectName,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextStyles.semiBold14(color: AppColors.black24),
                      ),
                      const SizedBox(height: 4),
                      if (lesson.lessonName != null)
                        Text(
                          lesson.lessonName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.normal12(color: AppColors.gray61),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        'GV: ${lesson.teacherName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normal12(color: AppColors.gray61),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
