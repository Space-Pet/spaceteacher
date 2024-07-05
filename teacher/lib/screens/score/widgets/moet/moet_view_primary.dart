import 'package:core/core.dart';
import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/evaluation.dart';
import 'package:teacher/screens/score/widgets/score_card_subject/primary_subject_score.dart';

class MoetViewPrimary extends StatefulWidget {
  const MoetViewPrimary({
    super.key,
    required this.diemMoetTxt,
    required this.semester,
    required this.moetAverage,
    required this.onNote,
  });

  final TxtDiemMoetType diemMoetTxt;
  final int semester;
  final MoetAverage moetAverage;
  final Function(String note) onNote;

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
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      return Column(children: [
        if (!state.edit)
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
                ...List.generate(widget.diemMoetTxt.diemData?.length ?? 0,
                    (index) {
                  final DiemItemType? subjectScoreData;

                  switch (widget.semester) {
                    case 1:
                      subjectScoreData =
                          widget.diemMoetTxt.diemData![index].diemGiuaHk1;
                      break;
                    case 2:
                      subjectScoreData =
                          widget.diemMoetTxt.diemData![index].diemCuoiHk1;
                      break;
                    case 3:
                      subjectScoreData =
                          widget.diemMoetTxt.diemData![index].diemGiuaHk2;
                      break;
                    default:
                      subjectScoreData =
                          widget.diemMoetTxt.diemData![index].diemCuoiNam;
                      break;
                  }

                  return PrimarySubjectScore(
                    subjectName:
                        widget.diemMoetTxt.diemData![index].subjectName,
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
        if (state.isMOET.contains('MOET'))
          StudentEvaluation(
            moetAverage: widget.moetAverage,
            onNote: (value) {
              widget.onNote(value);
            },
          ),
        // if ((widget.diemMoetTxt.nhanXetChungCuaGvcn ?? '').isNotEmpty)
        //   ScoreComment(comment: widget.diemMoetTxt.nhanXetChungCuaGvcn!),
      ]);
    });
  }
}
