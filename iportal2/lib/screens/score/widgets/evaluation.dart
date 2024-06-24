import 'package:core/data/models/primary_conduct.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/widgets/evaluation_item.dart';

class StudentEvaluation extends StatelessWidget {
  const StudentEvaluation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      builder: (context, state) {
        final conductData = state.primaryConduct.data;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/bold-note-clipboard.svg',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Đánh giá hạnh kiếm',
                    style: AppTextStyles.semiBold14(color: AppColors.brand600),
                  )
                ],
              ),
            ),
            EvaluationItem(
              listConduct: conductData.nangLucCotLoi.nangLucChung,
              listConductSecond: conductData.nangLucCotLoi.nangLucDacThu,
            ),
            EvaluationItem(
              listConduct: conductData.phamChatChuYeu,
              isMainConduct: true,
            ),
          ],
        );
      },
    );
  }
}

class EvaluationItem extends StatelessWidget {
  const EvaluationItem({
    super.key,
    this.isMainConduct = false,
    required this.listConduct,
    this.listConductSecond = const [],
  });

  final bool isMainConduct;
  final List<ConductItem> listConduct;
  final List<ConductItem> listConductSecond;

  @override
  Widget build(BuildContext context) {
    if (!isMainConduct) {
      listConduct.insert(
        0,
        ConductItem(
          hanhKiemName: 'Năng lực chung',
          hanhKiemValue: '',
          hanhKiemKey: '',
        ),
      );

      listConductSecond.insert(
        0,
        ConductItem(
          hanhKiemName: 'Năng lực đặc thù',
          hanhKiemValue: '',
          hanhKiemKey: '',
        ),
      );
    }

    final listConductW = List.generate(listConduct.length, (index) {
      final conduct = listConduct[index];
      return StudentEvaluationItem(
        label: conduct.hanhKiemName,
        result: conduct.hanhKiemValue,
        isLast: index == listConduct.length - 1,
        isBoldTitle: !isMainConduct && index == 0,
      );
    });

    final listConductSecondW = List.generate(listConductSecond.length, (index) {
      final conduct = listConductSecond[index];
      return StudentEvaluationItem(
        label: conduct.hanhKiemName,
        result: conduct.hanhKiemValue,
        isLast: index == listConductSecond.length - 1,
        isBoldTitle: !isMainConduct && index == 0,
      );
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(6),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          colors: isMainConduct
              ? const [
                  Color(0xFF6CDAA6),
                  Color(0xFF71E0AB),
                ]
              : const [
                  Color(0xFF78B6FF),
                  Color(0xff70B8FF),
                ],
          stops: const [0.0189, 0.9356],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: isMainConduct
                    ? const Color.fromRGBO(41, 177, 29, 1)
                    : const Color.fromRGBO(0, 122, 255, 1),
                child: SvgPicture.asset(
                  'assets/icons/emoji-normal.svg',
                  height: 12,
                  width: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isMainConduct ? 'Phẩm chất chủ yếu' : 'Năng lực cốt lõi',
                style: AppTextStyles.semiBold14(color: AppColors.white),
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
                children: listConductW,
              )),
          if (listConductSecond.isNotEmpty)
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
                child: Column(children: listConductSecondW)),
        ],
      ),
    );
  }
}
