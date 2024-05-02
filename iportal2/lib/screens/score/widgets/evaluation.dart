import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/widgets/evaluation_item.dart';
import 'package:iportal2/resources/resources.dart';

class StudentEvaluation extends StatelessWidget {
  const StudentEvaluation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) =>
          previous.primaryConduct != current.primaryConduct,
      builder: (context, state) {
        final primaryConduct = state.primaryConduct.data;

        final listEvaluation = [
          ...primaryConduct.nangLucCotLoi.nangLucChung,
          ...primaryConduct.nangLucCotLoi.nangLucDacThu,
        ];

        final listEvaluationW = List.generate(listEvaluation.length, (index) {
          final conduct = listEvaluation[index];
          return StudentEvaluationItem(
            label: conduct.hanhKiemName,
            result: conduct.hanhKiemValue,
            isLast: index == listEvaluation.length - 1,
          );
        });

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
                    'Đánh giá hạnh kiếm',
                    style: AppTextStyles.bold16(color: AppColors.brand600),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
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
                        const SizedBox(width: 8),
                        Text(
                          'Đánh giá phẩm chất',
                          style:
                              AppTextStyles.semiBold14(color: AppColors.white),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
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
                      child: Column(
                        children: listEvaluationW,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFEF0C7),
                      Color(0xFFFEF0C7),
                    ],
                    stops: [
                      0.0189,
                      0.9356,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: const Color(0xFFF88F33),
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
                          'Nhận xét chung của GVCN',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(12, 4, 16, 4),
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
                        child: Text(
                            primaryConduct.nhanXetChungCuaGvcn[0].hanhKiemValue,
                            style: AppTextStyles.normal14(
                              color: AppColors.gray600,
                            ))),
                  ],
                ),
              )
            ],
          ),
        ]);
      },
    );
  }
}
