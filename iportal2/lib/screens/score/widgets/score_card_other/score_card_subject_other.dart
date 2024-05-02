import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/score/widgets/score_card_other/card_expand_score_other.dart';

class EslCard extends StatefulWidget {
  const EslCard({
    super.key,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
    this.subjectName,
    required this.coreDataList,
  });
  final num index;
  final num lastIndex;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;
  final String? subjectName;
  final List<EslScoreData> coreDataList;

  @override
  State<EslCard> createState() => _EslCardState();
}

class _EslCardState extends State<EslCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onExpansionChanged,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
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
                  : const BorderRadius.all(Radius.circular(0)),
        ),
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
                      Text(
                        widget.subjectName ?? '',
                        style: AppTextStyles.semiBold12(
                          color: AppColors.blueGray800,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                    'assets/icons/${widget.isExpanded ? 'chevron-up' : 'chevron-down'}.svg',
                    colorFilter: const ColorFilter.mode(
                        AppColors.gray400, BlendMode.srcIn)),
              ],
            ),
            if (widget.isExpanded)
              EslCardExpand(coreDataList: widget.coreDataList)
          ],
        ),
      ),
    );
  }
}
