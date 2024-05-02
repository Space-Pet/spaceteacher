import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/resources.dart';

class PrimarySubjectScore extends StatelessWidget {
  const PrimarySubjectScore({
    super.key,
    required this.subjectScore,
    required this.subjectName,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
  });
  final DiemItemType? subjectScore;
  final String subjectName;
  final num index;
  final num lastIndex;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;

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
    return InkWell(
      onTap: onExpansionChanged,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
              bottom: BorderSide(
                color: AppColors.gray300,
              ),
            ),
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))
                : index == lastIndex
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
                          subjectName,
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
                SvgPicture.asset(
                    'assets/icons/${isExpanded ? 'chevron-up' : 'chevron-down'}.svg',
                    colorFilter: const ColorFilter.mode(
                        AppColors.gray400, BlendMode.srcIn)),
              ],
            ),
            if (isExpanded)
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 2),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                            color: AppColors.backgroundBrandRest2,
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Điểm trung bình môn',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray600,
                                  ),
                                ),
                                Text(
                                  subjectScore!.diemKtdk ?? '',
                                  style: AppTextStyles.semiBold14(
                                    color: AppColors.brand600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              color: AppColors.gray300,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mức đạt',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray600,
                                  ),
                                ),
                                Text(
                                  subjectScore!.mucDatDuoc ?? '',
                                  style: AppTextStyles.semiBold14(
                                    color: AppColors.brand600,
                                  ),
                                ),
                              ],
                            ),
                            if ((subjectScore!.nhanXet ?? '').isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                decoration: const BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.all(6),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/conversation-icon.svg',
                                        width: 16,
                                        height: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Nhận xét của giáo viên',
                                        style: AppTextStyles.normal12(
                                          color: AppColors.brand600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    subjectScore!.nhanXet ?? '',
                                    style: AppTextStyles.normal12(
                                        color: AppColors.gray700),
                                  ),
                                ]),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
