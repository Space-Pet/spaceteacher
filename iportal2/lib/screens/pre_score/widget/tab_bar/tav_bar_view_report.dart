import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:iportal2/screens/pre_score/widget/select_button/score_filter.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

enum TermType {
  term1,
  term2,
}

extension TermTypeX on TermType {
  String text() {
    switch (this) {
      case TermType.term1:
        return "Học kỳ 1 - Năm học 2023-2024";
      case TermType.term2:
        return "Học kỳ 2 - Năm học 2023-2024";
      default:
        return "Cuối kỳ";
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

  ViewScoreSelectedParam({required this.selectedTerm});

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

    preScoreBloc.add(GetListReportStudent(learnYear: learnYear));
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
  String selectedScoreType = "Điểm MOET";

  final List<Color> circleAvatarColors = [
    AppColors.red500,
    AppColors.brand600,
    AppColors.green600,
    Colors.orange,
  ];

  void handleSelectedOptionChanged(String newOption) async {
    setState(() {
      selectedScoreType = newOption;
    });
  }

  Color getTextColor(int type) {
    if (type >= 1 && type <= circleAvatarColors.length) {
      return circleAvatarColors[type - 1];
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final listReport = state.listReportStudent;
      final reportStudent = state.reportStudent;
      final isLoading =
          state.preScoreStatus == PreScoreStatus.loadingListReport;
      final isLoadingReport =
          state.preScoreStatus == PreScoreStatus.loadingReportStudent;
      return AppSkeleton(
        isLoading: isLoading,
        skeleton: SizedBox(
          height: 500,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: index == 4
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray300),
                ),
              ),
              child: SkeletonItem(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 10,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: ScoreFilter(
                          selectedOption: ViewScoreSelectedParam(
                            selectedTerm: state.txtHocKy!,
                          ),
                        ),
                      ),
                      Column(
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
                                    expandedTitleBackgroundColor: Colors.white,
                                    onToggleCollapsed: (value) {
                                      context.read<PreScoreBloc>().add(
                                          GetReportStudent(id: item?.id ?? 0));
                                    },
                                    titleChild: GestureDetector(
                                      onTap: () {
                                        context.read<PreScoreBloc>().add(
                                            GetReportStudent(
                                                id: item?.id ?? 0));
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
                                              padding: const EdgeInsets.only(
                                                  left: 5),
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
                                    contentChild: AppSkeleton(
                                        skeleton: SizedBox(
                                          height: 500,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(0),
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 12, 0, 12),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: index == 4
                                                      ? BorderSide.none
                                                      : const BorderSide(
                                                          color: AppColors
                                                              .gray300),
                                                ),
                                              ),
                                              child: SkeletonItem(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              SkeletonParagraph(
                                                            style:
                                                                SkeletonParagraphStyle(
                                                              lineStyle:
                                                                  SkeletonLineStyle(
                                                                randomLength:
                                                                    true,
                                                                height: 10,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        isLoading: isLoadingReport,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: reportStudent
                                                        ?.dataItems.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  final item = reportStudent
                                                      ?.dataItems[index];
                                                  return Padding(
                                                    padding: EdgeInsets.zero,
                                                    child: ExpansionTile(
                                                      tilePadding:
                                                          EdgeInsets.zero,
                                                      title: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .backgroundBrandRest),
                                                          child: Text(
                                                            item?.title ?? '',
                                                            style: AppTextStyles
                                                                .normal14(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .brand200,
                                                            ),
                                                          )),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: item
                                                                  ?.childrenItems
                                                                  .map(
                                                                      (childrenItem) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            16),
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .backgroundBrandRest,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          childrenItem
                                                                              .title,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: AppColors.brand600),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                        ...childrenItem
                                                                            .dataChildrenItems
                                                                            .map((dataChildrenItem) {
                                                                          return Column(
                                                                            children: [
                                                                              Text(
                                                                                dataChildrenItem.title,
                                                                                style: AppTextStyles.normal14(fontWeight: FontWeight.w700, color: AppColors.gray800),
                                                                              ),
                                                                              ...dataChildrenItem.listCriterial.map((e) {
                                                                                final marks = reportStudent?.listMarks.where((element) => element.id == e.result.first.markId);
                                                                                final markValues = marks?.map((mark) => mark.value).toList() ?? [];
                                                                                final textToShow = markValues.join(', ');
                                                                                Color textColor;
                                                                                if (textToShow == '1') {
                                                                                  textColor = Colors.red;
                                                                                } else if (textToShow == '2') {
                                                                                  textColor = AppColors.brand600;
                                                                                } else if (textToShow == '3') {
                                                                                  textColor = AppColors.green700;
                                                                                } else {
                                                                                  textColor = Colors.black;
                                                                                }
                                                                                return Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          const Padding(
                                                                                            padding: EdgeInsets.only(top: 6),
                                                                                            child: CircleAvatar(
                                                                                              backgroundColor: AppColors.brand600,
                                                                                              radius: 3,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.only(left: 8, right: 6),
                                                                                              child: Text(e.criterialTitle, overflow: TextOverflow.ellipsis, maxLines: 3),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      textToShow,
                                                                                      style: AppTextStyles.normal18(color: textColor, fontWeight: FontWeight.w700),
                                                                                    )
                                                                                  ],
                                                                                );
                                                                              })
                                                                            ],
                                                                          );
                                                                        }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList() ??
                                                              [],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                            Container(
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
                                                          reportStudent?.comment
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
                                                      reportStudent
                                                              ?.comment.value ??
                                                          '',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                          child:
                                                              SvgPicture.asset(
                                                                  Assets.icons
                                                                      .emoji),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8),
                                                          child: Text(
                                                            reportStudent
                                                                    ?.teacherName
                                                                    .label ??
                                                                '',
                                                            style: AppTextStyles.normal14(
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
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              AppColors.white),
                                                      child: Text(
                                                        reportStudent
                                                                ?.teacherName
                                                                .value ??
                                                            '',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
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
                                            )
                                          ],
                                        )));
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
