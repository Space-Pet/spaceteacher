import 'package:core/data/models/survay_data.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class TabViewSurvey extends StatefulWidget {
  const TabViewSurvey({
    super.key,
    this.index,
    required this.surveyQuestion,
    required this.listSurveyAnswer,
    this.indexQuestion,
  });

  final SurveyQuestion surveyQuestion;
  final int? index;
  final List<Map<String, dynamic>> listSurveyAnswer;
  final int? indexQuestion;

  @override
  State<TabViewSurvey> createState() => _TabViewSurveyState();
}

class _TabViewSurveyState extends State<TabViewSurvey> {
  late List<TextEditingController> textControllers;

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
    textControllers =
        List.generate(widget.surveyQuestion.cauHoi.length, (index) {
      return TextEditingController();
    });
  }

  @override
  dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void updateCheckboxStates(int questionIndex, int levelKey) {
    setState(() {
      final question = widget.surveyQuestion.cauHoi[questionIndex];

      final index = widget.listSurveyAnswer
          .indexWhere((element) => element['cauHoiId'] == question.cauHoiId);

      if (index != -1) {
        widget.listSurveyAnswer[index] = {
          'cauHoiId': question.cauHoiId,
          'cauTraLoiId': levelKey,
          'loaiCauHoi': question.loaiCauHoi,
        };
      } else {
        widget.listSurveyAnswer.add({
          'cauHoiId': question.cauHoiId,
          'cauTraLoiId': levelKey,
          'loaiCauHoi': question.loaiCauHoi,
        });
      }
    });
  }

  Widget buildCheckboxList(int questionIndex) {
    final int cauHoiId = widget.surveyQuestion.cauHoi[questionIndex].cauHoiId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: levelMap.entries.map((entry) {
          final String levelValue = entry.value;
          final levelKey = entry.key;

          final bool isChecked = widget.listSurveyAnswer.any((element) =>
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
    final surveyQuestion = widget.surveyQuestion;

    print('listSurveyAnswer ${widget.listSurveyAnswer}');

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 4),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            surveyQuestion.nhomCauHoi,
            style: AppTextStyles.semiBold16(
              color: AppColors.gray700,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: surveyQuestion.cauHoi.length,
            itemBuilder: (context, index) {
              final question = surveyQuestion.cauHoi[index];
              final isLastIndex = index == surveyQuestion.cauHoi.length - 1;
              final TextEditingController textSurvey = textControllers[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 6, 6, 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              question.noiDungCauHoi,
                              style: AppTextStyles.semiBold16(
                                color: AppColors.brand600,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    question.loaiCauHoi == 'option'
                        ? buildCheckboxList(index)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: TextField(
                                  controller: textSurvey,
                                  maxLines: 5,
                                  minLines: 3,
                                  onChanged: (content) {
                                    textSurvey.text = content;
                                    final newAnswer = {
                                      'cauHoiId': question.cauHoiId,
                                      'traLoiKhac': textSurvey.text,
                                      'loaiCauHoi': question.loaiCauHoi,
                                    };
                                    final existingAnswerIndex = widget
                                        .listSurveyAnswer
                                        .indexWhere((answer) =>
                                            answer['cauHoiId'] ==
                                            widget.indexQuestion);

                                    if (existingAnswerIndex != -1) {
                                      widget.listSurveyAnswer[
                                          existingAnswerIndex] = newAnswer;
                                    } else {
                                      widget.listSurveyAnswer.add(newAnswer);
                                    }
                                  },
                                  style: AppTextStyles.normal14(),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 14,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.gray400,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Nhập câu trả lời',
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
