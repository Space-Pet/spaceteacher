import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/bloc/assessment_bloc.dart';
import 'package:teacher/screens/observation_schedule/widgets/moet_questions.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AssessmentMoet extends StatelessWidget {
  const AssessmentMoet({super.key, required this.lessonRegisterId});

  static const String routeName = '/assessment_moet';
  final String lessonRegisterId;

  @override
  Widget build(BuildContext context) {
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final currentUserBloc = context.read<CurrentUserBloc>();
    final assessmentBloc = AssessmentBloc(
      appFetchApiRepository: appFetchApiRepository,
      currentUserBloc: currentUserBloc,
    );

    return BlocProvider.value(
      value: assessmentBloc
        ..add(GetAssessmentCriterias(lessonRegisterId: lessonRegisterId)),
      child: const EvaluationFormMoetView(),
    );
  }
}

class EvaluationFormMoetView extends StatefulWidget {
  const EvaluationFormMoetView({super.key});

  @override
  State<EvaluationFormMoetView> createState() => _EvaluationFormMoetViewState();
}

class _EvaluationFormMoetViewState extends State<EvaluationFormMoetView> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Criteria> listAnswer = [];
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentBloc, AssessmenState>(
      builder: (context, state) {
        final moetEvaluation = state.assessment;
        final isLoading = state.status == AssessmentStatus.loading;
        final isEmpty = moetEvaluation.listMoetCriteria.isEmpty && !isLoading;

        listAnswer = moetEvaluation.listMoetCriteria;

        final listCategory = moetEvaluation.listMoetCriteria
            .map((e) => e.tieuChiDanhMuc.trim())
            .toSet()
            .toList();

        Widget buildPageIndicator() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              listCategory.length,
              (index) => _buildIndicator(index),
            ),
          );
        }

        bool checkAnswers() {
          final listAnswerByCate = listAnswer
              .where((element) =>
                  element.tieuChiDanhMuc == listCategory[_currentPage])
              .toList();

          return listAnswerByCate.every((e) =>
              (e.tieuChiDiem != null &&
                  (e.diemDat != null && (e.diemDat ?? '').isNotEmpty)) ||
              (e.tieuChiDiem == null && e.nhanXet != null));
        }

        return Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'Đánh giá dự giờ MOET',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                    child: AppSkeleton(
                  isLoading: isLoading,
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
                            itemCount: listCategory.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final listMoetCriteria = moetEvaluation
                                  .listMoetCriteria
                                  .where((element) =>
                                      element.tieuChiDanhMuc.trim() ==
                                      listCategory[index])
                                  .toList();

                              return MoetEvaluationQuestions(
                                listAnswer: listAnswer,
                                category:
                                    '${listCategory[index]} (${listMoetCriteria.first.tieuChiTongDiem} điểm)',
                                listMoetCriteria: listMoetCriteria,
                                lessonRegisterId:
                                    moetEvaluation.lessonRegisterId,
                                diemType: moetEvaluation.diemType,
                              );
                            },
                          ),
                        ),
                        KeyboardVisibilityBuilder(
                            builder: (context, isKeyboardVisible) {
                          return isKeyboardVisible
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    buildPageIndicator(),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (_currentPage > 0)
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all<
                                                        Color>(
                                                  AppColors.gray200,
                                                ),
                                              ),
                                              onPressed: () {
                                                _pageController.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Text(
                                                'Quay lại',
                                                style: AppTextStyles.normal16(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                          Color>(
                                                      AppColors.brand500),
                                            ),
                                            onPressed: () {
                                              if (!checkAnswers()) {
                                                _showAlertDialog();
                                                return;
                                              }

                                              if (_currentPage ==
                                                  listCategory.length - 1) {
                                                context.pop();
                                              }

                                              _pageController.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            child: Text(
                                              _currentPage <
                                                      listCategory.length - 1
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
                                    const SizedBox(height: 16),
                                  ],
                                );
                        }),
                      ],
                    ),
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
        msg: 'Vui lòng nhập đầy đủ các điểm đạt',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.black,
        textColor: AppColors.white);
  }
}
