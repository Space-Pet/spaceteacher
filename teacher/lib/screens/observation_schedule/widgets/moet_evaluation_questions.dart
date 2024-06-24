import 'package:core/core.dart';
import 'package:core/data/models/moet_evaluation.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/bloc/hourly_assessment_bloc.dart';

class MoetEvaluationQuestions extends StatefulWidget {
  const MoetEvaluationQuestions({
    super.key,
    required this.listMoetCriteria,
    required this.category,
    this.diemType = 'float',
    required this.lessonRegisterId,
  });

  final List<MoetCriteria> listMoetCriteria;
  final String category;
  final String diemType;
  final String lessonRegisterId;

  @override
  State<MoetEvaluationQuestions> createState() =>
      _MoetEvaluationQuestionsState();
}

class _MoetEvaluationQuestionsState extends State<MoetEvaluationQuestions> {
  late List<TextEditingController> scoreControllers;
  late List<TextEditingController> commmentControllers;

  List<Map<String, dynamic>> listAnswer = [];

  final Map<int, String> levelMap = {
    4: 'Rất hài lòng',
    3: 'Hài lòng',
    2: 'Bình thường',
    1: 'Không hài lòng',
    0: 'Rất không hài lòng',
  };

  @override
  void initState() {
    super.initState();
    scoreControllers = List.generate(
        widget.listMoetCriteria.length, (index) => TextEditingController());

    commmentControllers = List.generate(
        widget.listMoetCriteria.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var scoreController in scoreControllers) {
      scoreController.dispose();
    }
    for (var commentController in commmentControllers) {
      commentController.dispose();
    }
    super.dispose();
  }

  void updateCheckboxStates(int questionIndex, int levelKey) {
    setState(() {
      final question = widget.listMoetCriteria[questionIndex];

      final index = listAnswer
          .indexWhere((element) => element['NOTE_ID'] == question.noteId);

      if (index != -1) {
        listAnswer[index] = {
          'noteId': question.noteId,
          'cauTraLoiId': levelKey,
        };
      } else {
        listAnswer.add({
          'noteId': question.noteId,
          'cauTraLoiId': levelKey,
        });
      }
    });
  }

  void onUpdateCriteria(MoetCriteria criteria) {
    final indexAnswer = listAnswer
        .indexWhere((element) => element['NOTE_ID'] == criteria.noteId);

    final indexController = widget.listMoetCriteria.indexOf(criteria);

    final updateItem = {
      "NOTE_ID": criteria.noteId,
      "tieu_chi_diem": criteria.tieuChiDiem,
      "diem_dat": scoreControllers[indexController].text,
      "nhan_xet": commmentControllers[indexController].text,
    };

    if (indexAnswer != -1) {
      listAnswer[indexAnswer] = updateItem;
    } else {
      listAnswer.add(updateItem);
    }

    print(listAnswer);
  }

  Widget buildCheckboxList(int questionIndex) {
    final String cauHoiId = widget.listMoetCriteria[questionIndex].noteId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: levelMap.entries.map((entry) {
          final String levelValue = entry.value;
          final levelKey = entry.key;

          final bool isChecked = listAnswer.any((element) =>
              element['cauHoiId'] == cauHoiId &&
              element['cauTraLoiId'] == levelKey);

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: InkWell(
              onTap: () {
                setState(() {
                  updateCheckboxStates(questionIndex, levelKey);
                });
              },
              child: Row(
                children: [
                  GFCheckbox(
                    size: 20,
                    activeBgColor: GFColors.WHITE,
                    type: GFCheckboxType.circle,
                    onChanged: (value) {
                      setState(() {
                        updateCheckboxStates(questionIndex, levelKey);
                      });
                    },
                    value: isChecked,
                    activeBorderColor: AppColors.brand600,
                    activeIcon: const Icon(
                      Icons.fiber_manual_record,
                      color: AppColors.brand600,
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      levelValue,
                      style: AppTextStyles.normal14(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              widget.category,
              style: AppTextStyles.semiBold16(
                color: AppColors.gray700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.listMoetCriteria.length,
              itemBuilder: (context, index) {
                final criteria = widget.listMoetCriteria[index];
                final TextEditingController scoreController =
                    scoreControllers[index];

                if (criteria.diemDat != null) {
                  scoreController.text = criteria.diemDat ?? '';
                }

                final TextEditingController commentController =
                    commmentControllers[index];

                if (criteria.nhanXet != null) {
                  commentController.text = criteria.nhanXet ?? '';
                }
                return Column(
                  children: [
                    Text(
                      criteria.tieuChiNoiDung,
                      style: AppTextStyles.semiBold16(
                        color: AppColors.brand600,
                      ),
                    ),
                    widget.diemType != 'float'
                        ? buildCheckboxList(index)
                        : Container(
                            margin: const EdgeInsets.only(top: 6, bottom: 8),
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.gray100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Điểm chuẩn: ${criteria.tieuChiDiem}',
                                        style: AppTextStyles.semiBold14(
                                          color: AppColors.brand600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Điểm đạt:',
                                            style: AppTextStyles.normal14(),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: 50,
                                            height: 28,
                                            child: TextField(
                                              onChanged: (score) {
                                                onUpdateCriteria(criteria);
                                              },
                                              onSubmitted: (score) {
                                                context
                                                    .read<
                                                        HourlyAssessmentBloc>()
                                                    .add(
                                                      UpdateCriteria(
                                                        lessonRegisterId: widget
                                                            .lessonRegisterId,
                                                        noteId: criteria.noteId,
                                                        diemDat: score,
                                                        tieuChiDiem: criteria
                                                            .tieuChiDiem
                                                            .toString(),
                                                        nhanXet:
                                                            commentController
                                                                .text,
                                                      ),
                                                    );
                                              },
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                decimal: true,
                                              ),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'[0-9]+[,.]{0,1}[0-9]*')),
                                                TextInputFormatter.withFunction(
                                                  (oldValue, newValue) =>
                                                      newValue.copyWith(
                                                    text: newValue.text
                                                        .replaceAll(',', '.'),
                                                  ),
                                                ),
                                              ],
                                              controller: scoreController,
                                              style: AppTextStyles.normal14(),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: AppColors.gray400,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: AppColors.brand600,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: AppColors.gray400,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 4,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.brand600,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.icons.features.report,
                                              width: 20,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Nhận xét',
                                              style: AppTextStyles.semiBold14(
                                                  color: AppColors.brand600),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        TextField(
                                          controller: commentController,
                                          maxLines: 4,
                                          minLines: 2,
                                          onTapOutside: (event) {
                                            context
                                                .read<HourlyAssessmentBloc>()
                                                .add(
                                                  UpdateCriteria(
                                                    lessonRegisterId:
                                                        widget.lessonRegisterId,
                                                    noteId: criteria.noteId,
                                                    diemDat:
                                                        scoreController.text,
                                                    tieuChiDiem: criteria
                                                        .tieuChiDiem
                                                        .toString(),
                                                    nhanXet:
                                                        commentController.text,
                                                  ),
                                                );
                                          },
                                          onChanged: (content) {
                                            onUpdateCriteria(criteria);
                                          },
                                          onSubmitted: (comment) {
                                            context
                                                .read<HourlyAssessmentBloc>()
                                                .add(
                                                  UpdateCriteria(
                                                    lessonRegisterId:
                                                        widget.lessonRegisterId,
                                                    noteId: criteria.noteId,
                                                    diemDat:
                                                        scoreController.text,
                                                    tieuChiDiem: criteria
                                                        .tieuChiDiem
                                                        .toString(),
                                                    nhanXet: comment,
                                                  ),
                                                );
                                          },
                                          style: AppTextStyles.normal14(),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 4),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: AppColors.gray400,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: AppColors.brand600,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: AppColors.gray400,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
