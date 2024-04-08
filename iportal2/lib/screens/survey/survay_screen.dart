import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/check_box/check_box.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/survey/model/survay.dart';
import 'package:iportal2/screens/survey/widget/check_box_survay.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<bool> checkboxStates = List.generate(
    surveys.length,
    (index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Khảo sát',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Text(
                    'Khảo sát độ hài lòng',
                    style: AppTextStyles.normal20(
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray900,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: surveys.length,
                    itemBuilder: (context, index) {
                      final survey = surveys[index];
                      final isLastIndex = index == surveys.length - 1;
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
                                      color: AppColors.brand600),
                                ),
                                Flexible(
                                  child: Text(
                                    survey.title,
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.brand600),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Column(
                              children:
                                  survey.questions.asMap().entries.map((entry) {
                                final String question = entry.value;
                                return Row(
                                  children: [
                                    CheckBoxItemSurvay(
                                      title: question,
                                      isChecked: checkboxStates[index],
                                      onTap: (isChecked) {
                                        checkboxStates[index] = isChecked;
                                      },
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 5,
                            color: AppColors.pink100,
                          ),
                          if (isLastIndex)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 26),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${surveys.length + 1}. Câu hỏi nhập text',
                                        style: AppTextStyles.semiBold14(
                                            color: AppColors.brand600),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextField(
                                    maxLines: 5,
                                    minLines: 3,
                                    style: AppTextStyles.normal16(),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 14),
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
                          if (isLastIndex)
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 24, top: 40),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.redMenu,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Hoàn thành khảo sát',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
