import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/dialog/dialog_scale_animated.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';

class RegisterLessons extends StatelessWidget {
  const RegisterLessons({
    super.key,
    required this.lessons,
    required this.title,
  });

  final List<LessonModel> lessons;
  final String title;

  @override
  Widget build(BuildContext context) {
    final lessonsWExpanded = List.generate(lessons.length, (index) {
      final lesson = lessons[index];

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: index == lessons.length - 1
              ? AppRadius.roundedBottom12
              : const BorderRadius.all(Radius.zero),
          color: AppColors.gray100,
          border: Border(
            bottom: index == lessons.length - 1
                ? BorderSide.none
                : const BorderSide(color: AppColors.gray300),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 6),
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiết ${lesson.number}',
                    style: AppTextStyles.normal14(color: AppColors.black24),
                  ),
                  const SizedBox(height: 4),
                  if (lesson.advice.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => DialogScaleAnimated(
                            title: 'Nhận xét',
                            content: lesson.advice,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/advice.svg'),
                          const SizedBox(width: 4),
                          Text(
                            'Nhận xét',
                            style: AppTextStyles.normal14(
                                color: AppColors.black24),
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
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lesson.name,
                              style: AppTextStyles.semiBold14(
                                  color: AppColors.black24),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              lesson.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal12(
                                  color: AppColors.gray61),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'GV: ${lesson.teacherName}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal12(
                                  color: AppColors.gray61),
                            ),
                          ],
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
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: AppRadius.roundedTop6,
          ),
          child: Text(
            'Buổi sáng',
            style: AppTextStyles.semiBold14(color: AppColors.brand600),
          ),
        ),
        Column(
          children: lessonsWExpanded,
        ),
      ],
    );
  }
}
