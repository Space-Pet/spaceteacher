import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/score/widgets/score_card_subject/card_expand_score.dart';
import 'package:core/resources/resources.dart';

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
  bool isStringType(String input) {
    if (input == 'n/a') {
      return false;
    }

    double? parsedDouble = double.tryParse(input);
    if (parsedDouble != null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tbmhk = widget.scoreCard.tbmhk ?? 'n/a';
    final isEmptyTbmhk = tbmhk == 'n/a';
    final isStringScore = isStringType(tbmhk);

    return InkWell(
      onTap: widget.onExpansionChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        height: widget.isExpanded ? 140.v : 48.v,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
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
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    isEmptyTbmhk
                        ? const SizedBox()
                        : Container(
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
                                Text('${isStringScore ? 'Mức' : 'Điểm'} đạt: ',
                                    style: AppTextStyles.normal12(
                                        color: AppColors.gray600)),
                                Text(
                                  isStringScore
                                      ? tbmhk
                                      : double.parse(tbmhk).toString(),
                                  style: AppTextStyles.bold12(
                                    color: isStringScore
                                        ? AppColors.brand600
                                        : AppColors.red900,
                                  ),
                                )
                              ],
                            ),
                          ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                        'assets/icons/${widget.isExpanded ? 'chevron-up' : 'chevron-down'}.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.gray400, BlendMode.srcIn)),
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
      ),
    );
  }
}
