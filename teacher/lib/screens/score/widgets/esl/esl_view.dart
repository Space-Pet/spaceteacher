import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/screens/score/widgets/score_card_other/score_card_subject_other.dart';

class EslView extends StatefulWidget {
  const EslView({
    super.key,
    this.eslScore,
  });

  final List<EslScoreData>? eslScore;

  @override
  State<EslView> createState() => _EslView();
}

class _EslView extends State<EslView> {
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
    // final eslScore = widget.eslScore;

    // final listEslId = eslScore!
    //     .map((e) => e.subjectEsl.subjectEslId)
    //     .toList()
    //     .toSet()
    //     .toList();

    final listEslW = List.generate(5, (index) {
      // final eslId = listEslId[index];
      // final dataById = eslScore!
      //     .where((element) => element.subjectEsl.subjectEslId == eslId)
      //     .toList();

      // final subjectName = dataById.first.subjectEsl.subjectEslName;

      return EslCard(
        subjectName: 'IELTS',
        //coreDataList: dataById,
        isExpanded: expandedIndex == index,
        onExpansionChanged: () => _handleExpansion(index),
        index: index,
        lastIndex: 5 - 1,
      );
    });

    return Container(
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
      child: Column(children: listEslW),
    );
  }
}
