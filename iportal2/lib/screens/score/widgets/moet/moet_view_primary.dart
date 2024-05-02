import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/widgets/evaluation.dart';
import 'package:iportal2/screens/score/widgets/score_card_subject/primary_subject_score.dart';

class MoetViewPrimary extends StatefulWidget {
  const MoetViewPrimary({
    super.key,
    required this.diemMoetTxt,
    required this.semester,
  });

  final TxtDiemMoetType diemMoetTxt;
  final PrimaryTermType semester;

  @override
  State<MoetViewPrimary> createState() => _MoetViewPrimary();
}

class _MoetViewPrimary extends State<MoetViewPrimary> {
  int? expandedIndex;

  void _handleExpansion(int index) {
    if (index == expandedIndex) {
      setState(() {
        expandedIndex = null;
      });
    } else {
      setState(() {
        expandedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border(
              top: BorderSide(
                color: AppColors.gray300,
              ),
              left: BorderSide(
                color: AppColors.gray300,
              ),
              right: BorderSide(
                color: AppColors.gray300,
              ),
            )),
        child: Column(
          children: [
            ...List.generate(widget.diemMoetTxt.diemData!.length, (index) {
              final DiemItemType? subjectScoreData;

              switch (widget.semester) {
                case PrimaryTermType.midTerm1:
                  subjectScoreData =
                      widget.diemMoetTxt.diemData![index].diemGiuaHk1;
                  break;
                case PrimaryTermType.term1:
                  subjectScoreData =
                      widget.diemMoetTxt.diemData![index].diemCuoiHk1;
                  break;
                case PrimaryTermType.midTerm2:
                  subjectScoreData =
                      widget.diemMoetTxt.diemData![index].diemGiuaHk2;
                  break;
                default:
                  subjectScoreData =
                      widget.diemMoetTxt.diemData![index].diemCuoiNam;
                  break;
              }

              return PrimarySubjectScore(
                subjectName: widget.diemMoetTxt.diemData![index].subjectName,
                subjectScore: subjectScoreData,
                isExpanded: expandedIndex == index,
                index: index,
                onExpansionChanged: () => _handleExpansion(index),
                lastIndex: widget.diemMoetTxt.diemData!.length - 1,
              );
            })
          ],
        ),
      ),
      const StudentEvaluation(),
      // if ((widget.diemMoetTxt.nhanXetChungCuaGvcn ?? '').isNotEmpty)
      //   ScoreComment(comment: widget.diemMoetTxt.nhanXetChungCuaGvcn!),
    ]);
  }
}

class ScoreComment extends StatelessWidget {
  const ScoreComment({
    super.key,
    required this.comment,
  });

  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
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
              const SizedBox(width: 6),
              Text(
                'Nhận xét chung của GVCN',
                style: AppTextStyles.bold14(color: AppColors.brand600),
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
              ),
              child: Text(comment,
                  style: AppTextStyles.normal14(color: AppColors.gray600))),
        ],
      ),
    );
  }
}
