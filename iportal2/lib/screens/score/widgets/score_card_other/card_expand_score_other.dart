import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/resources/resources.dart';

enum EslCardType { mark, gpa, comment }

extension EslCardTypeExtension on EslCardType {
  String get name {
    switch (this) {
      case EslCardType.mark:
        return 'Điểm';
      case EslCardType.gpa:
        return 'GPA';
      case EslCardType.comment:
        return 'End of Semester comments';
    }
  }
}

class EslCardExpand extends StatelessWidget {
  const EslCardExpand({
    super.key,
    required this.coreDataList,
  });

  final List<EslScoreData> coreDataList;

  @override
  Widget build(BuildContext context) {
    final coreDataW = List.generate(coreDataList.length, (index) {
      final score = coreDataList[index];

      final isGPA = score.markEslType == EslCardType.gpa.name;
      final isComment = score.markEslType == EslCardType.comment.name;

      final subjectName = isGPA
          ? EslCardType.gpa.name
          : score.subjectEslCore.subjectEslCoreName;

      return isComment
          ? Container(
              decoration: const BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
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
                      EslCardType.comment.name,
                      style: AppTextStyles.normal12(
                        color: AppColors.blueGray800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  score.subjectEslCore.subjectEslComment ?? '',
                  style: AppTextStyles.normal12(color: AppColors.gray700),
                ),
              ]),
            )
          : Container(
              margin: EdgeInsets.only(
                  bottom: index == coreDataList.length - 1 ? 0 : 10),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: AppColors.gray300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$subjectName: ',
                      style: AppTextStyles.normal14(color: AppColors.gray600)),
                  Text(
                    score.subjectEslCore.subjectEslCoreValue ?? '',
                    style: AppTextStyles.bold14(color: AppColors.red900),
                  )
                ],
              ),
            );
    });

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
                color: AppColors.backgroundBrandRest2,
                borderRadius: BorderRadius.circular(14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(children: coreDataW),
          )
        ]),
      ),
    );
  }
}
