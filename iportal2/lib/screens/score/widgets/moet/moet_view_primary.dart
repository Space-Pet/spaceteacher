import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/widgets/evaluation.dart';

class MoetViewPrimary extends StatefulWidget {
  const MoetViewPrimary({
    super.key,
    required this.diemMoetTxt,
    required this.semester,
    required this.isMoetProgram,
    required this.nhanXetChungCuaGvcn,
  });

  final TxtDiemMoetType diemMoetTxt;
  final PrimaryTermType semester;
  final bool isMoetProgram;
  final List<ConductItem> nhanXetChungCuaGvcn;

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
    return SingleChildScrollView(
      child: Column(children: [
        if (widget.isMoetProgram && widget.nhanXetChungCuaGvcn.isNotEmpty)
          ScoreComment(comment: widget.nhanXetChungCuaGvcn.first.hanhKiemValue),
        if ((widget.diemMoetTxt.nhanXetChungCuaGvcn ?? '').isNotEmpty)
          ScoreComment(comment: widget.diemMoetTxt.nhanXetChungCuaGvcn!),
        if (widget.isMoetProgram) const StudentEvaluation()
      ]),
    );
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
              padding: const EdgeInsets.fromLTRB(12, 4, 16, 4),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.white,
              ),
              child: Text(comment,
                  style: AppTextStyles.normal14(
                    color: AppColors.gray600,
                  ))),
        ],
      ),
    );
  }
}
