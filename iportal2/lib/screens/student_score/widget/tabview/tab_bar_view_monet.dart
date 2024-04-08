import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/student_score/student_score_screen.dart';
import 'package:iportal2/screens/student_score/widget/score_card_subject/score_card_subject.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:network_data_source/network_data_source.dart';

class TabViewMonet extends StatefulWidget {
  const TabViewMonet({
    super.key,
    required this.diemMoetTxt,
    required this.selectedOption,
  });

  final TxtDiemMoetType diemMoetTxt;
  final ViewScoreSelectedParam selectedOption;
  @override
  State<TabViewMonet> createState() => _TabViewMonet();
}

class _TabViewMonet extends State<TabViewMonet> {
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

  String _getScoreTypeName(String name) {
    if (name == ScoreType.monet.text()) {
      return 'MOET';
    } else if (name == ScoreType.other.text()) {
      return 'khác';
    } else if (name == ScoreType.oic.text()) {
      return 'OIC';
    } else {
      return 'MOET';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.diemMoetTxt != null)
        Column(
          children: [
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/document-medicine.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: Text(
                    'Kết quả rèn luyện chương trình ${_getScoreTypeName(widget.selectedOption.selectedScoreType)} học kỳ ${widget.selectedOption.selectedTerm}, năm học ${widget.selectedOption.selectedYear} ',
                    style: AppTextStyles.bold16(color: AppColors.brand600),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            if (widget.diemMoetTxt.dtbCn != null)
              SummaryGroup(
                category: 'Điểm trung bình môn',
                evaluation: widget.diemMoetTxt.dtbCn!,
                textColor: AppColors.red90001,
              ),
            if (widget.diemMoetTxt.kqht != null)
              SummaryGroup(
                category: 'Kết quả học tập',
                evaluation: widget.diemMoetTxt.kqht!,
                textColor: AppColors.brand600,
              ),
            if (widget.diemMoetTxt.kqrl != null)
              SummaryGroup(
                category: 'Kết quả rèn luyện',
                evaluation: widget.diemMoetTxt.kqrl!,
                textColor: AppColors.brand600,
              ),
            if (widget.diemMoetTxt.xlhlCn != null)
              SummaryGroup(
                category: 'Xếp loại học lực',
                evaluation: widget.diemMoetTxt.xlhlCn!,
                textColor: AppColors.brand600,
              ),
            if (widget.diemMoetTxt.xlhkCn != null)
              SummaryGroup(
                category: 'Xếp loại hạnh kiểm',
                evaluation: widget.diemMoetTxt.xlhkCn!,
                textColor: AppColors.brand600,
              ),
            if (widget.diemMoetTxt.danhHieuCn != null)
              SummaryGroup(
                category: 'Danh hiệu',
                evaluation: widget.diemMoetTxt.danhHieuCn!,
                textColor: AppColors.brand600,
              ),
          ],
        ),
      if (widget.diemMoetTxt.nhanXetGvcnCn != null)
        Container(
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
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                offset: Offset(0.0, 5.0),
                blurRadius: 20.0,
              ),
            ],
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
              const SizedBox(
                height: 8,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                        offset: Offset(0.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: Text(widget.diemMoetTxt.nhanXetGvcnCn!,
                      style: AppTextStyles.normal14(color: AppColors.gray600))),
            ],
          ),
        ),
      const SizedBox(
        height: 8,
      ),
      if (widget.diemMoetTxt.scoreData != null)
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
      // const StudentEvaluation()
    ]);
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
            offset: Offset(0.0, 5.0),
            blurRadius: 20.0,
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
