import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dialog_confirm.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/evaluation_form_moet.dart';

class HourAssessmentScreen extends StatelessWidget {
  static const routeName = '/hour_assessment';
  const HourAssessmentScreen({super.key, required this.lesson});

  final RegisteredLesson lesson;

  @override
  Widget build(BuildContext context) {
    final dateFomat = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(lesson.lessonRegisterDate));

    return Scaffold(
      body: BackGroundContainer(
          child: Column(
        children: [
          ScreenAppBar(
            title: 'Đánh giá dự giờ',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppRadius.roundedTop20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: AppRadius.rounded14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, bottom: 8),
                        child: Text(
                          'Phiếu dự giờ giáo viên',
                          style: AppTextStyles.semiBold18(
                              color: AppColors.brand600),
                        ),
                      ),
                      Column(
                        children: [
                          TextDotLineDialog(
                            title: 'Thời gian dự giờ',
                            value: dateFomat,
                          ),
                          TextDotLineDialog(
                              title: 'Giáo viên',
                              value: lesson.lessonRegisterTeacherName),
                          TextDotLineDialog(
                            title: 'Lớp',
                            value: lesson.lessonRegisterClassName,
                          ),
                          TextDotLineDialog(
                            title: 'Tiết',
                            value: lesson.lessonRegisterTietNum,
                          ),
                          TextDotLineDialog(
                            title: 'Môn',
                            value: lesson.lessonRegisterSubjectName,
                            isLastLine: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Chọn phiếu đánh giá:',
                    style: AppTextStyles.semiBold18(color: AppColors.brand600),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(EvaluationFormMoet(
                        lessonRegisterId: lesson.lessonRegisterId,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      elevation: 0,
                      backgroundColor: AppColors.brand500,
                      side: const BorderSide(color: AppColors.gray400),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Phiếu đánh giá dự giờ MOET',
                      style: AppTextStyles.semiBold16(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      elevation: 0,
                      backgroundColor: AppColors.brand500,
                      side: const BorderSide(color: AppColors.gray400),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Phiếu đánh giá dự giờ Tiếng Anh',
                      style: AppTextStyles.semiBold16(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
