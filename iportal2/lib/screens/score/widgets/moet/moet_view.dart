import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/score/widgets/score_card_subject/score_card_subject.dart';

class MoetView extends StatefulWidget {
  const MoetView({
    super.key,
    required this.diemMoetTxt,
    required this.isSecondSemester,
    required this.moetAverage,
  });

  final TxtDiemMoetType diemMoetTxt;
  final MoetAverage moetAverage;
  final bool isSecondSemester;

  @override
  State<MoetView> createState() => _TabViewMonet();
}

class _TabViewMonet extends State<MoetView> {
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
    final moetAverage = widget.moetAverage;
    final isMoetProgram = moetAverage.statusNote.contains('MOET');
    final averageData = moetAverage.txtDiemMoet;

    return SingleChildScrollView(
      child: Column(children: [
        if (isMoetProgram && moetAverage.txtClassName.isNotEmpty)
          Column(
            children: [
              SummaryGroup(
                category: 'Điểm trung bình',
                evaluation: averageData.diemTrungBinhHocKy.toString(),
                textColor: AppColors.red90001,
              ),
              SummaryGroup(
                category: 'Kết quả học tập',
                evaluation: averageData.ketQuaHocTapHocKy,
                textColor: AppColors.brand600,
              ),
              SummaryGroup(
                category: 'Kết quả rèn luyện',
                evaluation: averageData.ketQuaRenLuyenHocKy,
                textColor: AppColors.brand600,
              ),
              if (widget.isSecondSemester)
                Column(
                  children: [
                    SummaryGroup(
                      category: 'Điểm trung bình cả năm',
                      evaluation: averageData.diemTrungBinhCaNam.toString(),
                      textColor: AppColors.brand600,
                    ),
                    SummaryGroup(
                      category: 'Xếp loại học lực',
                      evaluation: averageData.xepLoaiHocLucCaNam ?? '',
                      textColor: AppColors.brand600,
                    ),
                    SummaryGroup(
                      category: 'Xếp loại hạnh kiểm',
                      evaluation: averageData.xepLoaiHanhKiemCaNam ?? '',
                      textColor: AppColors.brand600,
                    ),
                    SummaryGroup(
                      category: 'Danh hiệu',
                      evaluation: averageData.danhhieuCaNam ?? '',
                      textColor: AppColors.brand600,
                    ),
                  ],
                ),
            ],
          ),
        if ((averageData.nhanXetGvcnCaNam ?? '').isNotEmpty)
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
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
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Nhận xét',
                      style: AppTextStyles.bold14(color: AppColors.brand600),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.white,
                    ),
                    child: Text(averageData.nhanXetGvcnCaNam ?? 'nhan xet',
                        style:
                            AppTextStyles.normal14(color: AppColors.gray600))),
              ],
            ),
          ),
        if ((widget.diemMoetTxt.scoreData ?? []).isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
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
                ...List.generate(
                    widget.diemMoetTxt.scoreData!.length,
                    (index) => CardScoreSubject(
                        isExpanded: expandedIndex == index,
                        index: index,
                        onExpansionChanged: () => _handleExpansion(index),
                        scoreCard: widget.diemMoetTxt.scoreData![index],
                        lastIndex: widget.diemMoetTxt.scoreData!.length - 1))
              ],
            ),
          ),
      ]),
    );
  }
}

class SummaryGroup extends StatelessWidget {
  const SummaryGroup({
    super.key,
    required this.evaluation,
    required this.category,
    required this.textColor,
  });

  final String evaluation;
  final String category;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.10),
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              category,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal14(color: AppColors.blueGray700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Expanded(
            child: Text(
              evaluation,
              textAlign: TextAlign.center,
              style: AppTextStyles.bold18(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
