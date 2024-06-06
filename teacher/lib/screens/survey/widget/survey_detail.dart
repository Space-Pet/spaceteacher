import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/survey/bloc/survey_bloc.dart';
import 'package:teacher/screens/survey/widget/survey_question.dart';

class SurveyDetailScreen extends StatelessWidget {
  const SurveyDetailScreen({super.key, required this.khaoSatId});

  static const String routeName = '/survey-detail';
  final int khaoSatId;

  @override
  Widget build(BuildContext context) {
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final currentUserBloc = context.read<CurrentUserBloc>();
    final surveyBloc = SurveyBloc(
      appFetchApiRepository: appFetchApiRepository,
      currentUserBloc: currentUserBloc,
    );

    return BlocProvider.value(
      value: surveyBloc..add(GetSurvey(khaoSatId: khaoSatId)),
      child: const SurveyPageView(),
    );
  }
}

class SurveyPageView extends StatefulWidget {
  const SurveyPageView({super.key});

  @override
  State<SurveyPageView> createState() => _SurveyPageViewState();
}

class _SurveyPageViewState extends State<SurveyPageView> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Map<String, dynamic>> listSurveyAnswer = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(
      builder: (context, state) {
        final surveyDetail = state.surveyDetail;

        Widget buildPageIndicator() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              surveyDetail.questions.length,
              (index) => _buildIndicator(index),
            ),
          );
        }

        bool isAllQuestionsAnswered() {
          final currentSurveyData = surveyDetail.questions[_currentPage];
          final questions = currentSurveyData.cauHoi;

          for (final question in questions) {
            final cauHoiId = question.cauHoiId;
            if (!listSurveyAnswer
                .any((element) => element['cauHoiId'] == cauHoiId)) {
              return false;
            }
          }

          return true;
        }

        return Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'Khảo sát',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: surveyDetail.questions.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final surveyItem = surveyDetail.questions[index];
                            final isLastIndex =
                                index == surveyDetail.questions.length - 1;
                            if (!isLastIndex) {
                              return SurveyQuestionView(
                                listSurveyAnswer: listSurveyAnswer,
                                surveyQuestion: surveyItem,
                              );
                            } else {
                              return SurveyQuestionView(
                                indexQuestion: surveyItem.cauHoi.first.cauHoiId,
                                surveyQuestion: surveyItem,
                                index: index,
                                listSurveyAnswer: listSurveyAnswer,
                              );
                            }
                          },
                        ),
                      ),
                      buildPageIndicator(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (_currentPage > 0)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          AppColors.white),
                                ),
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Quay lại',
                                  style: AppTextStyles.normal16(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(
                                        AppColors.brand500),
                              ),
                              onPressed: () {
                                if (_currentPage <
                                    surveyDetail.questions.length - 1) {
                                  if (isAllQuestionsAnswered()) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    _showAlertDialog();
                                  }
                                } else {
                                  context.read<SurveyBloc>().add(PostSurvey(
                                        listSurvey: listSurveyAnswer,
                                        khaoSatId: surveyDetail.info.khaoSatId,
                                      ));
                                }
                              },
                              child: Text(
                                _currentPage < surveyDetail.questions.length - 1
                                    ? 'Tiếp theo'
                                    : 'Hoàn thành',
                                style: AppTextStyles.normal16(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicator(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: 5.0,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _currentPage == index ? AppColors.brand600 : AppColors.gray200,
        ),
      ),
    );
  }

  void _showAlertDialog() {
    Fluttertoast.showToast(
        msg: 'Vui lòng trả lời đủ câu hỏi trước khi tiếp tục.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.black,
        textColor: AppColors.white);
  }
}
