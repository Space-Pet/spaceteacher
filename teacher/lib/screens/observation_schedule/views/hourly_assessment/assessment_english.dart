import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/bloc/assessment_bloc.dart';
import 'package:teacher/screens/observation_schedule/widgets/english_criteiras.dart';

class AssessmentEnglish extends StatelessWidget {
  const AssessmentEnglish({super.key, required this.lessonRegisterId});

  static const String routeName = '/assessment_english';
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
        ..add(GetAssessmentCriterias(
          lessonRegisterId: lessonRegisterId,
          type: 'EN',
        )),
      child: const AssessmentEnglishView(),
    );
  }
}

class AssessmentEnglishView extends StatefulWidget {
  const AssessmentEnglishView({super.key});

  @override
  State<AssessmentEnglishView> createState() => _AssessmentEnglishViewState();
}

class _AssessmentEnglishViewState extends State<AssessmentEnglishView> {
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
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return BlocBuilder<AssessmentBloc, AssessmenState>(
      builder: (context, state) {
        final assessmentData = state.assessment;
        final isLoading = state.status == AssessmentStatus.loading;
        final isEmpty = assessmentData.listMoetCriteria.isEmpty && !isLoading;

        listAnswer = assessmentData.listMoetCriteria;

        final listCategory = assessmentData.listMoetCriteria
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
              (e.tieuChiDiemMax != null &&
                  (e.diemDat != null && (e.diemDat ?? '').isNotEmpty)) ||
              (e.tieuChiDiemMax == null && e.nhanXet != null));
        }

        return Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'Đánh giá dự giờ tiếng Anh',
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
                              final listMoetCriteria = assessmentData
                                  .listMoetCriteria
                                  .where((element) =>
                                      element.tieuChiDanhMuc.trim() ==
                                      listCategory[index])
                                  .toList();

                              return EnglishCriterias(
                                listAnswer: listAnswer,
                                category:
                                    '${listCategory[index]} (${listMoetCriteria.first.tieuChiDiemMax} điểm)',
                                listMoetCriteria: listMoetCriteria,
                                lessonRegisterId:
                                    assessmentData.lessonRegisterId,
                                diemType: assessmentData.diemType,
                              );
                            },
                          ),
                        ),
                        if (!_keyboardVisible)
                          Column(
                            children: [
                              buildPageIndicator(),
                              const SizedBox(height: 4),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (_currentPage > 0)
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
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
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
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
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Text(
                                        _currentPage < listCategory.length - 1
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
                          ),
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
