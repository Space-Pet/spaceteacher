import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/evaluation_item.dart';
import 'package:core/resources/resources.dart';

class StudentEvaluation extends StatefulWidget {
  StudentEvaluation({
    super.key,
    required this.moetAverage,
    required this.onNote,
  });
  final MoetAverage moetAverage;
  final Function(String note) onNote;

  @override
  State<StudentEvaluation> createState() => _StudentEvaluationState();
}

class _StudentEvaluationState extends State<StudentEvaluation> {
  late TextEditingController _controller;
  String note = '';
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.moetAverage.txtDiemMoet.nhanXetGvcnCaNam ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      builder: (context, state) {
        final edit = state.edit;
        final primaryConduct = state.primaryConduct.data;
        final listEvaluationNLCL = [
          [...primaryConduct.nangLucCotLoi.nangLucChung],
          [...primaryConduct.nangLucCotLoi.nangLucDacThu],
        ];
        final listEvaluation = [...primaryConduct.phamChatChuYeu];
        final listEvaluationW = List.generate(listEvaluation.length, (index) {
          final conduct = listEvaluation[index];
          return StudentEvaluationItem(
            label: conduct.hanhKiemName,
            result: conduct.hanhKiemValue ?? '',
            isLast: index == listEvaluation.length - 1,
          );
        });

        final titles = ['Năng lực chung', 'Năng lực đặc thù'];
        final listEvaluationNLTables =
            listEvaluationNLCL.asMap().entries.map((entry) {
          final index = entry.key;
          final conductList = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  titles[index],
                  style: AppTextStyles.bold16(color: AppColors.brand600),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: conductList.map((item) {
                    return Column(
                      children: [
                        StudentEvaluationItem(
                          label: item.hanhKiemName,
                          result: item.hanhKiemValue ?? '',
                          isLast: item == conductList.last,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }).toList();

        return Column(children: [
          const SizedBox(height: 18),
          if (!edit)
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bold-note-clipboard.svg',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Đánh giá hạnh kiếm',
                      style: AppTextStyles.bold16(color: AppColors.brand600),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF78B6FF),
                        Color(0xFF70B8FF),
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
                            backgroundColor: const Color(0xFF278BEB),
                            child: SvgPicture.asset(
                              'assets/icons/emoji-normal.svg',
                              height: 12,
                              width: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Đánh giá phẩm chất',
                            style: AppTextStyles.semiBold14(
                                color: AppColors.white),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
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
                        child: Column(
                          children: listEvaluationNLTables,
                        ),
                      ),
                    ],
                  ),
                ), // Adding separate tables for evaluations
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6CDAA6),
                        Color(0xFF71E0AB),
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
                            backgroundColor:
                                const Color.fromRGBO(41, 177, 29, 1),
                            child: SvgPicture.asset(
                              'assets/icons/emoji-normal.svg',
                              height: 12,
                              width: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Đánh giá phẩm chất',
                            style: AppTextStyles.semiBold14(
                                color: AppColors.white),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
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
                        child: Column(
                          children: listEvaluationW,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    const SizedBox(width: 4),
                    Text(
                      'Nhận xét chung của GVCN',
                      style:
                          AppTextStyles.semiBold14(color: AppColors.brand600),
                    )
                  ],
                ),
                const SizedBox(height: 8),
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
        ]);
      },
    );
  }
}
