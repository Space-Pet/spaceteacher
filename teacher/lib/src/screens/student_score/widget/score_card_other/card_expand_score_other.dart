import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/resources/app_text_styles.dart';

import 'package:teacher/src/screens/student_score/widget/score_card_subject/score_subject_model.dart';

class CardExpandScoreOther extends StatelessWidget {
  const CardExpandScoreOther({
    super.key,
    this.isTimeTableView = false,
    required this.scoreCard,
  });

  final ScoreSubjectModel scoreCard;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 2),
        child: Row(children: [
          Container(
            width: 4,
            height: isTimeTableView ? 51 : 180,
            decoration: BoxDecoration(
                color: AppColors.backgroundBrandRest2,
                borderRadius: BorderRadius.circular(14)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(color: AppColors.gray300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Điểm Quiz: ',
                          style:
                              AppTextStyles.normal12(color: AppColors.gray600)),
                      Text(
                        scoreCard.score,
                        style: AppTextStyles.bold12(color: AppColors.red900),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(color: AppColors.gray300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Điểm Reading: ',
                          style:
                              AppTextStyles.normal12(color: AppColors.gray600)),
                      Text(
                        scoreCard.score,
                        style: AppTextStyles.bold12(color: AppColors.red900),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(color: AppColors.gray300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Điểm Listening: ',
                          style:
                              AppTextStyles.normal12(color: AppColors.gray600)),
                      Text(
                        scoreCard.score,
                        style: AppTextStyles.bold12(color: AppColors.red900),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  child: Column(children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/conversation-icon.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Nhận xét giáo viên",
                          style: AppTextStyles.normal12(
                            color: AppColors.blueGray800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      scoreCard.advice,
                      style: AppTextStyles.normal12(color: AppColors.gray700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/avatar.png'),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "GV: ",
                          style:
                              AppTextStyles.normal12(color: AppColors.gray900),
                        ),
                        Text(
                          scoreCard.teacherName,
                          style:
                              AppTextStyles.normal12(color: AppColors.gray900),
                        )
                      ],
                    )
                  ]),
                ),
              ],
            ),
          )
        ]),
      );
    });
  }
}
