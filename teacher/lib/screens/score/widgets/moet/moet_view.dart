import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/score_card_subject/score_card_subject.dart';

class MoetView extends StatefulWidget {
  const MoetView({
    super.key,
    required this.isMOET,
    required this.learnYear,
    required this.phoneBookStudent,
    required this.semester,
    required this.onNote,
    required this.moetAverage,
  });

  final bool isMOET;
  final String learnYear;
  final PhoneBookStudent phoneBookStudent;
  final int semester;
  final Function(String note) onNote;
  final MoetAverage moetAverage;

  @override
  State<MoetView> createState() => _TabViewMonet();
}

class _TabViewMonet extends State<MoetView> {
  int? expandedIndex;
  late TextEditingController _controller;
  String note = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

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
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      final diemMoetTxt = state.moetScore.txtDiem;
      final isSecondSemester = state.termType == 2;
      final edit = state.edit;
      _controller = TextEditingController(
          text: widget.moetAverage.txtDiemMoet.nhanXetGvcnCaNam);
      return Column(children: [
        if (widget.isMOET)
          Column(
            children: [
              if (edit == false)
                SummaryGroup(
                  category: 'Điểm trung bình môn',
                  evaluation: state.termType == 1
                      ? widget.moetAverage.txtDiemMoet.diemTrungBinhHocKy
                      : widget.moetAverage.txtDiemMoet.diemTrungBinhCaNam ??
                          'N/A',
                  textColor: AppColors.red90001,
                ),
              if (edit == false)
                SummaryGroup(
                  category: 'Kết quả học tập',
                  evaluation: diemMoetTxt.kqht ?? '',
                  textColor: AppColors.brand600,
                ),
              if (edit == false)
                SummaryGroup(
                  category: 'Kết quả rèn luyện',
                  evaluation: diemMoetTxt.kqrl ?? '',
                  textColor: AppColors.brand600,
                ),
              if (isSecondSemester)
                Column(
                  children: [
                    if (edit == false)
                      SummaryGroup(
                        category: 'Xếp loại học lực',
                        evaluation: diemMoetTxt.xlhlCn ?? '',
                        textColor: AppColors.brand600,
                      ),
                    SummaryGroup(
                      category: 'Xếp loại hạnh kiểm',
                      evaluation: diemMoetTxt.xlhkCn ?? '',
                      textColor: AppColors.brand600,
                    ),
                    if (edit == false)
                      SummaryGroup(
                        category: 'Danh hiệu',
                        evaluation: diemMoetTxt.danhHieuCn ?? '',
                        textColor: AppColors.brand600,
                      ),
                  ],
                ),
            ],
          ),
        if (widget.isMOET)
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
                Column(
                  children: [
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
                      child: TextField(
                        readOnly: !edit,
                        maxLines: null,
                        controller: _controller,
                        onChanged: (value) {
                          note = value;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                        style: AppTextStyles.normal14(color: AppColors.gray600),
                      ),
                    ),
                  ],
                ),
                if (edit)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ScoreBloc>()
                                  .add(EditScore(edit: !edit));
                              widget.onNote(note);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: AppColors.brand500,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text('Lưu',
                                  style: AppTextStyles.semiBold14(
                                      color: AppColors.white)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ScoreBloc>()
                                  .add(EditScore(edit: !edit));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                'Quay lại',
                                style: AppTextStyles.semiBold14(
                                    color: const Color(0xFF9C292E)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(
          height: 8,
        ),
        if (edit == false)
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
                    diemMoetTxt.diemData?.length ??
                        diemMoetTxt.scoreData?.length ??
                        0,
                    (index) => CardScoreSubject(
                        scoreCard: diemMoetTxt.scoreData![index],
                        isExpanded: expandedIndex == index,
                        index: index,
                        onExpansionChanged: () => _handleExpansion(index),
                        //scoreCard: widget.diemMoetTxt.scoreData![index],
                        lastIndex: (diemMoetTxt.diemData?.length ??
                                diemMoetTxt.scoreData?.length ??
                                0) -
                            1))
              ],
            ),
          ),
      ]);
    });
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
