import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/select_button/score_filter.dart';
import 'package:repository/repository.dart';

enum TermType {
  term1,
  term2,
}

extension TermTypeX on TermType {
  String text() {
    int currentYear = DateTime.now().year;
    int previousYear = currentYear - 1;
    switch (this) {
      case TermType.term1:
        return "Học kỳ 1 - Năm học $previousYear-$currentYear";
      case TermType.term2:
        return "Học kỳ 2 - Năm học $previousYear-$currentYear";
      default:
        return "Cuối kỳ - Năm học $previousYear-$currentYear";
    }
  }

  String getValue() {
    switch (this) {
      case TermType.term1:
        return "1";
      case TermType.term2:
        return "2";
      default:
        return "3";
    }
  }
}

class ViewScoreSelectedParam {
  final String selectedTerm;

  ViewScoreSelectedParam({
    required this.selectedTerm,
  });

  ViewScoreSelectedParam copyWith({
    String? selectedTerm,
  }) {
    return ViewScoreSelectedParam(
      selectedTerm: selectedTerm ?? this.selectedTerm,
    );
  }

  @override
  String toString() {
    return 'ViewScoreSelectedParam(selectedTerm: $selectedTerm)';
  }
}

class TabBarViewReport extends StatelessWidget {
  const TabBarViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
    final currentYear = DateTime.now().year;

    final lastYear = currentYear - 1;

    final learnYear = '$lastYear-$currentYear';

    preScoreBloc.add(GetListReportStudent(learnYear: learnYear, semester: 1));
    return BlocProvider.value(
      value: preScoreBloc,
      child: const TabBarReport(),
    );
  }
}

class TabBarReport extends StatefulWidget {
  const TabBarReport({super.key});
  @override
  State<TabBarReport> createState() => _TabBarReportState();
}

class _TabBarReportState extends State<TabBarReport> {
  final List<Color> circleAvatarColors = [
    AppColors.red500,
    AppColors.brand600,
    AppColors.green600,
    Colors.orange,
  ];

  Color getTextColor(int type) {
    if (type >= 1 && type <= circleAvatarColors.length) {
      return circleAvatarColors[type - 1];
    } else {
      return Colors.black;
    }
  }

  late String selectedTerm = "1";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final listReport = state.listReportStudent;
      final reportStudent = state.reportStudent;
      final isLoading =
          state.preScoreStatus == PreScoreStatus.loadingListReport;
      final isLoadingReport =
          state.preScoreStatus == PreScoreStatus.loadingReportStudent;
      final currentYear = DateTime.now().year;

      final lastYear = currentYear - 1;

      final learnYear = '$lastYear-$currentYear';
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: ScoreFilter(
              selectedOption: ViewScoreSelectedParam(
                selectedTerm: state.txtHocKy!,
              ),
              onUpdateTerm: (value) {
                if (value == 'Học kỳ 1 - Năm học $learnYear') {
                  context.read<PreScoreBloc>().add(
                      GetListReportStudent(learnYear: learnYear, semester: 1));
                } else {
                  context.read<PreScoreBloc>().add(
                      GetListReportStudent(learnYear: learnYear, semester: 2));
                }
              },
            ),
          ),
          Expanded(
            child: AppSkeleton(
              isLoading: isLoading,
              child: Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listReport?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = listReport?[index];
                            return GFAccordion(
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                expandedTitleBackgroundColor: AppColors.white,
                                onToggleCollapsed: (value) {
                                  context
                                      .read<PreScoreBloc>()
                                      .add(GetReportStudent(id: item?.id ?? 0));
                                },
                                titleChild: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<PreScoreBloc>().add(
                                          GetReportStudent(id: item?.id ?? 0));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.icons.features.report,
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              item?.title ?? '',
                                              style: AppTextStyles.normal16(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.brand600,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis, // Truncate text if it's too long
                                              maxLines:
                                                  2, // Maximum 2 lines of text
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                contentChild: AppSkeleton(
                                    isLoading: isLoadingReport,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: AppColors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ListViewReport(
                                          //   reportStudent: reportStudent,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.warning100),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.orange400,
                                                        radius: 10,
                                                        child: SvgPicture.asset(
                                                            Assets.icons.emoji),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          'Nhận xét của giáo viên',
                                                          style: AppTextStyles
                                                              .normal14(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .brand600),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors.white),
                                                    child: Text(
                                                      reportStudent
                                                              ?.comment.value ??
                                                          '',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 16,
                                                left: 8,
                                                right: 8),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.green50),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .ellipse818,
                                                        radius: 10,
                                                        child: SvgPicture.asset(
                                                            Assets.icons.emoji),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          reportStudent
                                                                  ?.teacherName
                                                                  .label ??
                                                              '',
                                                          style: AppTextStyles
                                                              .normal14(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .brand600),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors.white),
                                                    child: Text(
                                                      reportStudent?.teacherName
                                                              .value ??
                                                          '',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .backgroundBrandRest,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6, left: 6),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          Assets.icons.features
                                                              .report,
                                                          width: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 6),
                                                          child: Text(
                                                            'Thang đánh giá',
                                                            style: AppTextStyles
                                                                .normal16(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .brand600,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        children: reportStudent
                                                                ?.listMarks
                                                                .map((entry) {
                                                              int textToShow =
                                                                  entry.value;
                                                              Color textColor;
                                                              if (textToShow ==
                                                                  1) {
                                                                textColor =
                                                                    Colors.red;
                                                              } else if (textToShow ==
                                                                  2) {
                                                                textColor =
                                                                    AppColors
                                                                        .brand600;
                                                              } else if (textToShow ==
                                                                  3) {
                                                                textColor =
                                                                    AppColors
                                                                        .green700;
                                                              } else {
                                                                textColor =
                                                                    Colors
                                                                        .black;
                                                              }
                                                              return Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        textColor,
                                                                    radius: 10,
                                                                    child: Text(
                                                                      entry
                                                                          .value
                                                                          .toString(),
                                                                      style: AppTextStyles.normal14(
                                                                          color:
                                                                              AppColors.white),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                    child:
                                                                        RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        text:
                                                                            '',
                                                                        style: DefaultTextStyle.of(context)
                                                                            .style,
                                                                        children: <TextSpan>[
                                                                          TextSpan(
                                                                            text:
                                                                                '${entry.title}: ',
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                entry.description,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }).toList() ??
                                                            [],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )));
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
