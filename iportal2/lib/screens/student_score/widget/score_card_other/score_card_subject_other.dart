import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/student_score/widget/score_card_other/card_expand_score_other.dart';
import 'package:iportal2/screens/student_score/widget/score_card_subject/score_subject_model.dart';
import 'package:iportal2/resources/resources.dart';

class CardScoreSubjectOther extends StatefulWidget {
  const CardScoreSubjectOther({
    super.key,
    required this.scoreCard,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
  });
  final ScoreSubjectModel scoreCard;
  final num index;
  final num lastIndex;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;
  @override
  State<CardScoreSubjectOther> createState() => _CardScoreSubjectOtherState();
}

class _CardScoreSubjectOtherState extends State<CardScoreSubjectOther> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      height: widget.isExpanded ? 246 : 48,
      decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(
              color: AppColors.gray300,
            ),
          ),
          borderRadius: widget.index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))
              : widget.index == widget.lastIndex
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))
                  : const BorderRadius.all(Radius.circular(0))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: const BoxDecoration(
                    color: AppColors.backgroundBrandRest,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bold-note-document.svg',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.scoreCard.name,
                      style: AppTextStyles.semiBold12(
                        color: AppColors.blueGray800,
                        height: 20 / 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onExpansionChanged,
                    child: SvgPicture.asset(
                        'assets/icons/${widget.isExpanded ? 'minus' : 'chevron-down'}.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.gray400, BlendMode.srcIn)),
                  ),
                ],
              ),
            ],
          ),
          widget.isExpanded
              ? Expanded(
                  child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: CardExpandScoreOther(scoreCard: widget.scoreCard)))
              : Container()
        ],
      ),
    );
  }
}
