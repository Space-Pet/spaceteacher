import 'package:core/core.dart';
import 'package:core/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/esl/esl_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view_primary.dart';
import 'package:teacher/screens/score/widgets/score_filter.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

import '../../components/empty_screen.dart';

class ScoreScreen extends StatelessWidget {
  static const String routeName = 'score';

  const ScoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
        final scoreBloc = context.read<ScoreBloc>();
        final scoreData = state.moetScore;
        final eslScore = state.eslScore;

        final khoiLevel = int.parse(
            scoreData.txtKhoiLevel.isEmpty ? '0' : scoreData.txtKhoiLevel);
        final isPrimary = khoiLevel < 6;

        void onUpdateYear(String newYear) {
          scoreBloc.add(ScoreFilterChange(
            ViewScoreSelectedParam(
              selectedScoreType: state.scoreType,
              selectedTerm:
                  isPrimary ? state.txtTihHocKy.text() : state.txtHocKy.text(),
              selectedYear: newYear,
            ),
            isPrimary,
          ));
          // scoreBloc.add(ScoreFetchMoet());
        }

        final isLoading = state.status == ScoreStatus.loading;
        final isEmptyData = state.status == ScoreStatus.loaded &&
            (isPrimary
                ? scoreData.txtDiemMoet.diemData!.isEmpty
                : scoreData.txtDiemMoet.scoreData!.isEmpty);

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScoreAppbar(
                scoreData: scoreData,
                selectedOption: state.txtLearnYear,
                onUpdateYear: onUpdateYear,
              ),
              Expanded(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScoreFilter(
                        isPrimary: isPrimary,
                        onSelectedOption: (ViewScoreSelectedParam newOption) {
                          scoreBloc
                              .add(ScoreFilterChange(newOption, isPrimary));
                          if (newOption.selectedScoreType ==
                              ScoreType.moet.text()) {
                            scoreBloc.add(ScoreFetchMoet());
                          } else {
                            scoreBloc.add(ScoreFetchEsl());
                          }
                        },
                        selectedOption: ViewScoreSelectedParam(
                          selectedScoreType: state.scoreType,
                          selectedTerm: isPrimary
                              ? state.txtTihHocKy.text()
                              : state.txtHocKy.text(),
                          selectedYear: state.txtLearnYear,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.401, 1.0],
                              colors: [
                                Color(0xFFDFEEFF),
                                Color(0xFFFFFFFF),
                                Color(0xFFFFFFFF),
                              ],
                            ),
                          ),
                          child: CustomRefresh(
                            onRefresh: () async {
                              if (state.scoreType == ScoreType.moet.text()) {
                                scoreBloc.add(ScoreFetchMoet());
                              } else {
                                scoreBloc.add(ScoreFetchEsl());
                              }
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: AppSkeleton(
                                isLoading: isLoading,
                                skeleton: const SkeletonScore(),
                                child: isEmptyData
                                    ? const EmptyScreen(
                                        text: 'Chưa có dữ liệu',
                                      )
                                    : state.scoreType == ScoreType.esl.text()
                                        ? EslView(eslScore: eslScore.data)
                                        : isPrimary
                                            ? MoetViewPrimary(
                                                diemMoetTxt:
                                                    scoreData.txtDiemMoet,
                                                semester: state.txtTihHocKy,
                                              )
                                            : MoetView(
                                                diemMoetTxt:
                                                    scoreData.txtDiemMoet,
                                                isSecondSemester:
                                                    scoreData.txtCurrentHocKy ==
                                                        '2',
                                              ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ScoreAppbar extends StatelessWidget {
  const ScoreAppbar({
    super.key,
    required this.scoreData,
    required this.selectedOption,
    required this.onUpdateYear,
  });

  final ScoreModel scoreData;
  final String selectedOption;
  final void Function(String newYear) onUpdateYear;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ScreenAppBar(
            title: 'Xem điểm',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 28, right: 16),
          width: 130,
          child: DropdownButtonComponent(
            selectedOption: selectedOption,
            onUpdateOption: onUpdateYear,
            hint: 'Chọn năm học',
            optionList: scoreData.listYear,
            isSelectYear: true,
          ),
        ),
      ],
    );
  }
}

class SkeletonScore extends StatelessWidget {
  const SkeletonScore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final listSkeleton = List.generate(
        6,
        (index) => SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  padding: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  height: 44,
                  borderRadius: AppRadius.rounded10),
            ));

    return SkeletonItem(
      child: Column(
        children: [
          Column(
            children: listSkeleton,
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
                padding: const EdgeInsets.only(bottom: 12),
                width: double.infinity,
                height: 90,
                borderRadius: AppRadius.rounded10),
          ),
        ],
      ),
    );
  }
}

class ViewScoreSelectedParam {
  final String selectedYear;
  final String selectedScoreType;
  final String selectedTerm;

  ViewScoreSelectedParam(
      {required this.selectedYear,
      required this.selectedScoreType,
      required this.selectedTerm});

  ViewScoreSelectedParam copyWith({
    String? selectedYear,
    String? selectedScoreType,
    String? selectedTerm,
  }) {
    return ViewScoreSelectedParam(
      selectedYear: selectedYear ?? this.selectedYear,
      selectedScoreType: selectedScoreType ?? this.selectedScoreType,
      selectedTerm: selectedTerm ?? this.selectedTerm,
    );
  }
}
