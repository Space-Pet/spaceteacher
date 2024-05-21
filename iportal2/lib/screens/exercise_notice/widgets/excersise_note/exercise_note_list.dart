import 'package:core/data/models/models.dart';
import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_decoration.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/utils/validation_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class ExerciseItemList extends StatelessWidget {
  const ExerciseItemList({
    super.key,
    required this.exercise,
    this.isTodayView = false,
    this.isHomeScreenView = false,
  });

  final List<ExerciseItem> exercise;
  final bool isTodayView;
  final bool isHomeScreenView;

  @override
  Widget build(BuildContext context) {
    final listInstructionW = List.generate(exercise.length, (index) {
      final exerCise = exercise[index];

      final filePath = exerCise.fileBaoBai ?? '';
      final fileName = getFileName(filePath);

      return Container(
        margin: EdgeInsets.only(bottom: isHomeScreenView ? 6 : 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: AppRadius.rounded20,
          color: AppColors.white,
        ),
        child: isTodayView
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerCise.subjectName,
                    style: AppTextStyles.bold14(
                      color: AppColors.black20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GV: ${exerCise.teacherName}',
                    style: AppTextStyles.normal14(
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (exerCise.danDoBaoBai != null)
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/advice.svg'),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            exerCise.danDoBaoBai!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyles.normal14(
                              color: AppColors.gray600,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.blueGray100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      exerCise.subjectName,
                      style: AppTextStyles.normal14(color: AppColors.brand600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (exerCise.hanNopBaoBai != null)
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock-time.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Hạn nộp: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(exerCise.hanNopBaoBai!))}',
                          style: AppTextStyles.normal14(
                            color: AppColors.brand600,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (exerCise.fileBaoBai!.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        launchUrl(
                          Uri.parse(
                              'https://${exerCise.fileBaoBaiDomain}/${exerCise.fileBaoBai}'),
                          mode: LaunchMode.inAppBrowserView,
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/paperclip.svg'),
                          const SizedBox(width: 4),
                          Text(
                            fileName,
                            style: AppTextStyles.normal14(
                                color: AppColors.brand600),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      );
    });

    return Column(children: listInstructionW);
  }
}
