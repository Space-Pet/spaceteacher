import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/student_score/widget/score_card_subject/card_expand_score.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:network_data_source/network_data_source.dart';

class CardScoreSubject extends StatefulWidget {
  const CardScoreSubject({
    super.key,
    required this.scoreCard,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
  });
  final ScoreDataType scoreCard;
  final num index;
  final num lastIndex;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;
  @override
  State<CardScoreSubject> createState() => _CardScoreSubjectState();
}

class _CardScoreSubjectState extends State<CardScoreSubject> {
  bool _checkStringType(String input) {
    double? parsedDouble = double.tryParse(input);
    if (parsedDouble != null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      height: widget.isExpanded ? 138 : 48,
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
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 2, maxWidth: 170),
                      child: Text(
                        widget.scoreCard.subjectName,
                        style: AppTextStyles.semiBold12(
                          color: AppColors.blueGray800,
                          height: 20 / 14,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Truncate the text with an ellipsis if it overflows
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  if (!_checkStringType(widget.scoreCard.tbmhk!))
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(color: AppColors.gray300),
                      ),
                      child: Row(
                        children: [
                          Text('Điểm đạt: ',
                              style: AppTextStyles.normal12(
                                  color: AppColors.gray600)),
                          Text(
                            widget.scoreCard.tbmhk!,
                            style:
                                AppTextStyles.bold12(color: AppColors.red900),
                          )
                        ],
                      ),
                    ),
                  if (_checkStringType(widget.scoreCard.tbmhk!))
                    const SizedBox(
                      width: 12,
                    ),
                  if (_checkStringType(widget.scoreCard.tbmhk!))
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(color: AppColors.gray300),
                      ),
                      child: Row(
                        children: [
                          Text('Mức đạt: ',
                              style: AppTextStyles.normal12(
                                  color: AppColors.gray600)),
                          Text(
                            widget.scoreCard.tbmhk!,
                            style:
                                AppTextStyles.bold12(color: AppColors.brand600),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
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
                      child: CardExpandScore(scoreCard: widget.scoreCard)))
              : Container()
        ],
      ),
    );
  }
}
