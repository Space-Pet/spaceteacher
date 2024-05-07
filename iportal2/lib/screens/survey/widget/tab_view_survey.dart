import 'package:core/data/models/survay_data.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class TabViewSurvey extends StatefulWidget {
  const TabViewSurvey(
      {super.key,
      required this.surveyData,
      required this.isShow,
      this.index,
      required this.listSurvey,
      required this.onNextPage,
      this.indexQuestion});
  final SurveyData surveyData;
  final bool isShow;
  final int? index;
  final List<Map<String, dynamic>> listSurvey;
  final Function(List<Map<String, dynamic>>) onNextPage;
  final int? indexQuestion;
  @override
  State<TabViewSurvey> createState() => _TabViewSurveyState();
}

class _TabViewSurveyState extends State<TabViewSurvey> {
  final TextEditingController textSurvey = TextEditingController();
  final Map<int, String> levelMap = {
    4: 'Rất hài lòng',
    3: 'Hài lòng',
    2: 'Bình thường',
    1: 'Không hài lòng',
    0: 'Rất không hài lòng',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Text(
            widget.surveyData.nhomCauHoi,
            style: AppTextStyles.normal20(
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),
        ),
        if (widget.isShow)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.surveyData.question.length,
              itemBuilder: (context, index) {
                final question = widget.surveyData.question[index];
                // ignore: unused_local_variable
                final isLastIndex =
                    index == widget.surveyData.question.length - 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 26),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: AppTextStyles.semiBold14(
                              color: AppColors.brand600,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              question.noiDungCauHoi,
                              style: AppTextStyles.semiBold14(
                                color: AppColors.brand600,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildCheckboxList(index),
                    Container(
                      width: double.infinity,
                      height: 5,
                      color: AppColors.pink100,
                    ),
                  ],
                );
              },
            ),
          ),
        if (!widget.isShow)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
                child: Row(
                  children: [
                    Text(
                      '${widget.index! + 1}. Câu hỏi nhập text',
                      style: AppTextStyles.semiBold14(
                        color: AppColors.brand600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: textSurvey,
                  maxLines: 5,
                  minLines: 3,
                  onChanged: (content) {
                    textSurvey.text = content;
                    final newAnswer = {
                      'cauHoiId': widget.indexQuestion,
                      'traLoiKhac': textSurvey.text,
                    };
                    final existingAnswerIndex = widget.listSurvey.indexWhere(
                        (answer) => answer['cauHoiId'] == widget.indexQuestion);
                    if (existingAnswerIndex != -1) {
                      widget.listSurvey[existingAnswerIndex] = newAnswer;
                    } else {
                      widget.listSurvey.add(newAnswer);
                    }
                  },
                  style: AppTextStyles.normal16(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.gray300,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.gray400,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Nhập câu trả lời',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.gray300,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildCheckboxList(int questionIndex) {
    final int cauHoiId = widget.surveyData.question[questionIndex].cauHoiId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: levelMap.entries.map((entry) {
          final String levelValue = entry.value;
          final levelKey = entry.key;

          final bool isChecked = widget.listSurvey.any((element) =>
              element['cauHoiId'] == cauHoiId &&
              element['cauTraLoiId'] == levelKey);

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              children: [
                GFCheckbox(
                  size: 20,
                  activeBgColor: GFColors.WHITE,
                  type: GFCheckboxType.circle,
                  onChanged: (value) {
                    setState(() {
                      _updateCheckboxStates(questionIndex, levelKey);
                    });
                  },
                  value: isChecked,
                  activeBorderColor: Colors.red,
                  activeIcon: const Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    levelValue,
                    style: AppTextStyles.normal16(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _updateCheckboxStates(int questionIndex, int levelKey) {
    setState(() {
      final int cauHoiId = widget.surveyData.question[questionIndex].cauHoiId;

      final index = widget.listSurvey
          .indexWhere((element) => element['cauHoiId'] == cauHoiId);

      if (index != -1) {
        widget.listSurvey[index] = {
          'cauHoiId': cauHoiId,
          'cauTraLoiId': levelKey,
        };
      } else {
        widget.listSurvey.add({
          'cauHoiId': cauHoiId,
          'cauTraLoiId': levelKey,
        });
      }
    });
  }
}
