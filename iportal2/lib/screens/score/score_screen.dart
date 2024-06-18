import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/dropdown/dropdown.dart';
import 'package:iportal2/screens/score/bloc/score_bloc.dart';
import 'package:iportal2/screens/score/widgets/esl/esl_view.dart';
import 'package:iportal2/screens/score/widgets/moet/moet_view.dart';
import 'package:iportal2/screens/score/widgets/moet/moet_view_primary.dart';
import 'package:iportal2/screens/score/widgets/score_filter.dart';
import 'package:repository/repository.dart';

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
        final isPrimary = state.isPrimaryStudent;

        final programListName = state.programList.map((e) => e.ctName).toList();
        final isLoadingProgramList =
            state.programListStatus == ScoreProgramStatus.loading;

        final moetTypeScore = state.moetTypeScore;
        final isLoadingScore = state.status == ScoreStatus.loading;
        final isEmptyMoetTypeScore = state.status == ScoreStatus.loaded &&
            (isPrimary
                ? (moetTypeScore.txtDiem.diemData ?? []).isEmpty
                : (moetTypeScore.txtDiem.scoreData ?? []).isEmpty);

        final eslScore = state.eslScore;
        final isEmptyESLScore = eslScore.data.isEmpty && !isLoadingScore;

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScoreAppbar(
                selectedOption: state.txtLearnYear,
                onUpdateYear: (newYear) {
                  scoreBloc.add(ScoreFilterChange(
                    ViewScoreSelectedParam(
                      selectedYear: newYear,
                      filterType: FilterType.learnYear,
                    ),
                  ));
                },
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
                  child: AppSkeleton(
                    isLoading: isLoadingProgramList,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScoreFilter(
                          isPrimary: isPrimary,
                          programList: programListName,
                          onSelectedOption: (ViewScoreSelectedParam newOption) {
                            scoreBloc.add(ScoreFilterChange(newOption));
                          },
                          selectedOption: ViewScoreSelectedParam(
                            selectedScoreProgram: state.scoreProgram.ctName,
                            selectedTerm: isPrimary
                                ? state.txtTihHocKy.text()
                                : state.txtHocKy.text(),
                            selectedYear: state.txtLearnYear,
                          ),
                        ),
                        Expanded(
                          child: AppSkeleton(
                            isLoading: isLoadingScore,
                            child: Container(
                              width: double.infinity,
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
                                  scoreBloc.add(ScoreFetchData());
                                },
                                child: Stack(
                                  children: [
                                    ListView(),
                                    state.scoreProgram.ctId == 'esl'
                                        ? isEmptyESLScore
                                            ? const Center(
                                                child: EmptyScreen(
                                                  text: 'Không có dữ liệu',
                                                ),
                                              )
                                            : EslView(eslScore: eslScore.data)
                                        : isEmptyMoetTypeScore
                                            ? const Center(
                                                child: EmptyScreen(
                                                  text: 'Không có dữ liệu',
                                                ),
                                              )
                                            : isPrimary
                                                ? MoetViewPrimary(
                                                    diemMoetTxt:
                                                        moetTypeScore.txtDiem,
                                                    isMoetProgram: moetTypeScore
                                                        .statusNote
                                                        .contains('MOET'),
                                                    semester: state.txtTihHocKy,
                                                  )
                                                : MoetView(
                                                    diemMoetTxt:
                                                        moetTypeScore.txtDiem,
                                                    moetAverage:
                                                        state.moetAverage,
                                                    isSecondSemester:
                                                        moetTypeScore
                                                                .txtHocKy ==
                                                            '2',
                                                  ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
    required this.selectedOption,
    required this.onUpdateYear,
  });

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
        BlocBuilder<CurrentUserBloc, CurrentUserState>(
          builder: (context, state) {
            final learnYear = state.activeChild.learnYearList!.toList();

            return Container(
              margin: const EdgeInsets.only(top: 28, right: 16),
              width: 130,
              child: DropdownButtonComponent(
                selectedOption: selectedOption,
                onUpdateOption: onUpdateYear,
                hint: 'Chọn năm học',
                optionList: learnYear,
                isSelectYear: true,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ViewScoreSelectedParam {
  final String? selectedYear;
  final String? selectedScoreProgram;
  final String? selectedTerm;
  final FilterType? filterType;

  ViewScoreSelectedParam({
    this.selectedYear,
    this.selectedScoreProgram,
    this.selectedTerm,
    this.filterType = FilterType.program,
  });

  ViewScoreSelectedParam copyWith({
    String? selectedYear,
    String? selectedScoreProgram,
    String? selectedTerm,
    FilterType? filterType,
  }) {
    return ViewScoreSelectedParam(
      selectedYear: selectedYear ?? this.selectedYear,
      selectedScoreProgram: selectedScoreProgram ?? this.selectedScoreProgram,
      selectedTerm: selectedTerm ?? this.selectedTerm,
      filterType: filterType ?? this.filterType,
    );
  }
}
