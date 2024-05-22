import 'package:core/data/models/survay_data.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/screens/survey/bloc/survey_bloc.dart';
import 'package:iportal2/screens/survey/widget/tab_view_survey.dart';

class SurveyPageView extends StatefulWidget {
  final List<SurveyData> surveyData;

  const SurveyPageView({super.key, required this.surveyData});

  @override
  State<SurveyPageView> createState() => _SurveyPageViewState();
}

class _SurveyPageViewState extends State<SurveyPageView> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Map<String, dynamic>> listSurvey = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: widget.surveyData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final surveyItem = widget.surveyData[index];
              final isLastIndex = index == widget.surveyData.length - 1;
              if (!isLastIndex) {
                return TabViewSurvey(
                  listSurvey: listSurvey,
                  surveyData: surveyItem,
                  isShow: true,
                  onNextPage: (updatedListSurvey) {
                    listSurvey = updatedListSurvey;
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                );
              } else {
                return TabViewSurvey(
                  indexQuestion: surveyItem.question.first.cauHoiId,
                  surveyData: surveyItem,
                  isShow: false,
                  index: index,
                  listSurvey: listSurvey,
                  onNextPage: (updatedListSurvey) {
                    listSurvey = updatedListSurvey;
                    if (_isAllQuestionsAnswered()) {
                    } else {
                      _showAlertDialog();
                    }
                  },
                );
              }
            },
          ),
        ),
        _buildPageIndicator(),
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
                        WidgetStateProperty.all<Color>(AppColors.white),
                  ),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    'Quay lại',
                    style: AppTextStyles.normal16(fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(AppColors.red),
                ),
                onPressed: () {
                  if (_currentPage < widget.surveyData.length - 1) {
                    if (_isAllQuestionsAnswered()) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _showAlertDialog();
                    }
                  } else {
                    context
                        .read<SurveyBloc>()
                        .add(PostSurvey(listSurvey: listSurvey));
                  }
                },
                child: Text(
                  _currentPage < widget.surveyData.length - 1
                      ? 'Tiếp theo'
                      : 'Hoàn thành',
                  style: AppTextStyles.normal16(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.surveyData.length,
        (index) => _buildIndicator(index),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: 5.0,
        width: 50,
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

  bool _isAllQuestionsAnswered() {
    final currentSurveyData = widget.surveyData[_currentPage];
    final questions = currentSurveyData.question;

    for (final question in questions) {
      final cauHoiId = question.cauHoiId;
      if (!listSurvey.any((element) => element['cauHoiId'] == cauHoiId)) {
        return false;
      }
    }

    return true;
  }
}
