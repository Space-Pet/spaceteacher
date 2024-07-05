import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/components/dialog/show_dialog.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/exercise_notice/bloc/exercise_bloc.dart';
import 'package:teacher/screens/schedule/bloc/schedule_bloc.dart';
import 'package:teacher/utils/validation_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class ExerciseLesson extends StatelessWidget {
  const ExerciseLesson({
    super.key,
    required this.lesson,
    required this.noBoder,
  });

  final List<LessonDataItem> lesson;
  final bool noBoder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
      final classType = state.classType.value;

      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: lesson.length,
          itemBuilder: (context, index) {
            final item = lesson[index];

            final filePath = item.fileBaoBai ?? '';
            final fileName = getFileName(filePath);

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
                  SizedBox(
                    width: 110.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiết ${item.tietNum}',
                          style: AppTextStyles.normal14(
                            color: AppColors.black24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (item.danDoBaoBai != null)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShowDialog(
                                      title: 'Dặn dò',
                                      textConten: item.danDoBaoBai ?? '',
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Assets.icons.advice.svg(),
                                const SizedBox(width: 4),
                                Text(
                                  'Lời dặn',
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
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 4,
                            decoration: BoxDecoration(
                                color: AppColors.brand600,
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 2,
                                    classType != 1
                                        ? 'Lớp ${item.className}'
                                        : item.subjectName,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.green600),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (item.lessonName != null ||
                                    (item.lessonName ?? '').isNotEmpty)
                                  Text(
                                    item.lessonName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.normal14(
                                        color: AppColors.gray61),
                                  ),
                                const SizedBox(height: 4),
                                if (item.hanNopBaoBai != null)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/clock-time.svg',
                                        width: 14,
                                        height: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Hạn nộp: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.hanNopBaoBai ?? ''))}',
                                        style: AppTextStyles.normal14(),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 8),
                                if (item.fileBaoBai != null)
                                  GestureDetector(
                                    onTap: () async {
                                      launchUrl(
                                        Uri.parse(
                                            'https://${item.fileBaoBaiDomain}/${item.fileBaoBai}'),
                                        mode: LaunchMode.inAppBrowserView,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/paperclip.svg'),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            fileName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.normal14(
                                                color: AppColors.brand600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
