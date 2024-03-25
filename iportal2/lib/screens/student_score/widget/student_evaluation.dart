import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/student_score/widget/student_evaluation_item.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/resources.dart';

class StudentEvaluation extends StatelessWidget {
  const StudentEvaluation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          const SizedBox(height: 18),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bold-note-clipboard.svg',
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Đánh giá năng lực và phẩm chất',
                style: AppTextStyles.bold16(color: AppColors.brand600),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF78B6FF), // #78B6FF
                  Color(0xFF70B8FF), // #70B8FF
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.iconBackground,
                      child: SvgPicture.asset(
                        'assets/icons/emoji-normal.svg',
                        height: 12,
                        width: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Đánh giá năng lực',
                      style: AppTextStyles.bold14(color: AppColors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                        offset: Offset(0.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      StudentEvaluationItem(
                        label: 'Tự phục vụ, tự quản',
                        result: "T",
                      ),
                      StudentEvaluationItem(
                        label: 'Hợp tác',
                        result: "Đ",
                      ),
                      StudentEvaluationItem(
                        label: 'Tự học, tự giải quyết vấn đề',
                        result: "Đ",
                        isLast: true,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColors.gray300))),
                        child: Text("Nhận xét",
                            style: AppTextStyles.bold14(
                                color: AppColors.brand600)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                            "Trung thực trong học tập. Đoàn kết giúp đỡ bạn bè.",
                            style: AppTextStyles.normal14(
                                color: AppColors.gray600)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6CDAA6),
                  Color(0xFF71E0AB),
                ],
                stops: [
                  0.0189,
                  0.9356,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: const Color.fromRGBO(41, 177, 29, 1),
                      child: SvgPicture.asset(
                        'assets/icons/emoji-normal.svg',
                        height: 12,
                        width: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Đánh giá phẩm chất',
                      style: AppTextStyles.bold14(color: AppColors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                        offset: Offset(0.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      StudentEvaluationItem(
                        label: 'Chăm học, chăm làm',
                        result: "T",
                      ),
                      StudentEvaluationItem(
                        label: 'Tự tin, trách nhiệm',
                        result: "Đ",
                      ),
                      StudentEvaluationItem(
                        label: 'Trung thực kỷ luật',
                        result: "Đ",
                      ),
                      StudentEvaluationItem(
                        label: 'Đoàn kết, yêu thương',
                        result: "Đ",
                        isLast: true,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColors.gray300))),
                        child: Text("Nhận xét",
                            style: AppTextStyles.bold14(
                                color: AppColors.brand600)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                            "Trung thực trong học tập. Đoàn kết giúp đỡ bạn bè.",
                            style: AppTextStyles.normal14(
                                color: AppColors.gray600)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ]);
  }
}
