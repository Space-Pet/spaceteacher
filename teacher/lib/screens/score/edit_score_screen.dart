import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/esl/esl_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view_primary.dart';
import 'package:teacher/screens/score/widgets/score_filter.dart';
import 'package:repository/repository.dart';

class EditScoreScreen extends StatelessWidget {
  static const String routeName = 'scoreEdit';

  const EditScoreScreen({
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
            scoreData.txtClassName.isEmpty ? '0' : scoreData.txtClassName);
        final isPrimary = khoiLevel < 6;

        final isLoading =
            state.status == ScoreStatus.loadingSemesterLeaderTeacher;

        final semester = state.semester;
        final user = state.localTeacher;
        print('value term: ${state.termType}');
        final termValue = state.termType;
        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScoreAppbar(
                scoreData: scoreData,
                selectedOption: state.txtLearnYear,
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
                        semesterList: semester,
                        isPrimary: isPrimary,
                        onSelectedOption: (ViewScoreSelectedParam newOption) {
                          print('check: ${state.scoreType}');
                          scoreBloc.add(ScoreFilterChange(newOption));
                        },
                        selectedOption: ViewScoreSelectedParam(
                          selectedScoreType: state.scoreType,
                          selectedTerm: semester.first.title,
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
                              // if (state.scoreType == ScoreType.moet.text()) {
                              //   scoreBloc.add(ScoreFetchMoet());
                              // } else {
                              //   scoreBloc.add(ScoreFetchEsl());
                              // }
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: AppSkeleton(
                                  isLoading: isLoading,
                                  child: state.scoreType == ScoreType.esl.text()
                                      ? const EslView()
                                      : user.cap_dao_tao.name == 'Phổ thông'
                                          ? MoetViewPrimary()
                                          : MoetView(
                                              isSecondSemester: termValue == 2,
                                            )

                                  //  isEmptyData
                                  //     ? const EmptyScreen(
                                  //         text: 'Chưa có dữ liệu',
                                  //       )
                                  //     :
                                  // state.scoreType == ScoreType.esl.text()
                                  //     ? EslView(eslScore: eslScore.data)
                                  //     : isPrimary
                                  //         ? MoetViewPrimary(
                                  //             diemMoetTxt:
                                  //                 scoreData.txtDiemMoet,
                                  //             semester: state.txtTihHocKy,
                                  //           )
                                  //         : MoetView(
                                  //             diemMoetTxt:
                                  //                 scoreData.txtDiemMoet,
                                  //             isSecondSemester:
                                  //                 scoreData.txtCurrentHocKy ==
                                  //                     '2',
                                  //           ),
                                  //     MoetViewPrimary(
                                  //   diemMoetTxt: scoreData.txtDiemMoet,
                                  //   //semester: state.txtTihHocKy,
                                  // ),
                                  //     MoetView(
                                  //   diemMoetTxt: scoreData.txtDiemMoet,
                                  //   isSecondSemester:
                                  //       scoreData.txtCurrentHocKy == '2',
                                  // ),
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
  });

  final ScoreModel scoreData;
  final String selectedOption;

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
      ],
    );
  }
}

class ViewScoreSelectedParam {
  final String selectedYear;
  final String selectedScoreType;
  final String selectedTerm;
  final int valueTerm;

  ViewScoreSelectedParam(
      {required this.selectedYear,
      this.valueTerm = 1,
      required this.selectedScoreType,
      required this.selectedTerm});

  ViewScoreSelectedParam copyWith({
    int? valueTerm,
    String? selectedYear,
    String? selectedScoreType,
    String? selectedTerm,
  }) {
    return ViewScoreSelectedParam(
      valueTerm: valueTerm ?? this.valueTerm,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedScoreType: selectedScoreType ?? this.selectedScoreType,
      selectedTerm: selectedTerm ?? this.selectedTerm,
    );
  }
}
