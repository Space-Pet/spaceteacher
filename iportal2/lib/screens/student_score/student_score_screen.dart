import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/select_child.dart';
import 'package:iportal2/screens/student_score/bloc/score_bloc.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_year/select_option_button_year.dart';
import 'package:iportal2/screens/student_score/widget/tabview/tab_bar_view_monet.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:repository/repository.dart';
import '../../resources/app_colors.dart';

enum TermType {
  term1,
  term2,
}

extension TermTypeX on TermType {
  String text() {
    switch (this) {
      case TermType.term1:
        return "Học kỳ 1";
      case TermType.term2:
        return "Học kỳ 2";
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

enum ScoreType {
  monet,
  other,
  oic,
}

extension ScoreTypeX on ScoreType {
  String text() {
    switch (this) {
      case ScoreType.monet:
        return "Điểm MOET";
      case ScoreType.other:
        return "Điểm chương trình khác";
      case ScoreType.oic:
        return "Điểm OIC";
      default:
        return "Cuối kỳ";
    }
  }
}

enum TermCountType {
  first,
  second,
}

extension TermcountTypeX on TermCountType {
  String text() {
    switch (this) {
      case TermCountType.first:
        return "Học kỳ 1";
      case TermCountType.second:
        return "Học kỳ 2";
      default:
        return "Học kỳ 1";
    }
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

  @override
  String toString() {
    return 'ViewScoreSelectedParam(selectedYear: $selectedYear, selectedScoreType: $selectedScoreType, selectedTerm: $selectedTerm)';
  }
}

class StudentScoreScreen extends StatelessWidget {
  const StudentScoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const BackGroundContainer(child: ScoreDataBloc());
  }
}

class ScoreDataBloc extends StatelessWidget {
  const ScoreDataBloc({
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
        final scoreData = state.scoreData;
        final scoreBloc = context.read<ScoreBloc>();
        void handleSelectedOptionChanged(ViewScoreSelectedParam newOption) {
          scoreBloc.add(ScoreFilterChange(newOption));
          scoreBloc.add(ScoreFetchData());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenAppBar(
                  title: 'Xem điểm',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                if (state.txtHocKy != null &&
                    state.txtLearnYear != null &&
                    state.scoreType != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 12),
                    child: SelectPopupSheetYear(
                      handleSelectedOptionChanged: handleSelectedOptionChanged,
                      selectedOption: ViewScoreSelectedParam(
                          selectedScoreType: state.scoreType!,
                          selectedTerm: state.txtHocKy!,
                          selectedYear: state.txtLearnYear!),
                      optionList: scoreData.listYear,
                    ),
                  ),
              ],
            ),
            if (state.txtHocKy != null &&
                state.txtLearnYear != null &&
                state.scoreType != null)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SelectChild(),
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
                                Color(0xFFDFEEFF), // #DFEEFF
                                Color(0xFFFFFFFF), // #FFF
                                Color(0xFFFFFFFF), // #FFF
                              ],
                            ),
                          ),
                          child: Expanded(
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: TabViewMonet(
                                selectedOption: ViewScoreSelectedParam(
                                    selectedScoreType: state.scoreType!,
                                    selectedTerm: state.txtHocKy!,
                                    selectedYear: state.txtLearnYear!),
                                diemMoetTxt: scoreData.txtDiemMoet,
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
        );
      }),
    );
  }
}
