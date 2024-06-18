import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/views/class_score/widgets/class_score_tab.dart';

class ClassScoreScreen extends StatelessWidget {
  const ClassScoreScreen({
    super.key,
    required this.listClassScore,
  });
  final ClassScore listClassScore;
  static const String routeName = '/class-score';

  @override
  Widget build(BuildContext context) {
    final scoreBloc = ScoreBloc(
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(ScoreSemesterListClass(capDaoTao: listClassScore.capDaoTao));
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ScoreBloc, ScoreState>(
        listener: (context, state) {
          if (state.status == ScoreStatus.successSemesterTeacher) {
            scoreBloc.add(
              GetFormInputScore(
                classId: listClassScore.classId,
                learnYear: '2023-2024',
                semester: state.semesterTabTeaching.first.value,
                subjectId: listClassScore.subjectId,
              ),
            );
          }
        },
        child: ClassScoreView(
          listClassScore: listClassScore,
        ),
      ),
    );
  }
}

class ClassScoreView extends StatefulWidget {
  const ClassScoreView({super.key, required this.listClassScore});
  final ClassScore listClassScore;
  @override
  State<ClassScoreView> createState() => ClassScoreViewState();
}

class ClassScoreViewState extends State<ClassScoreView> {
  var _selectedOption = 'Học kỳ 1';

  @override
  Widget build(BuildContext context) {
    void onUpdateTerm(Semester semester) {
      print(semester.value);
    }

    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      final semester = state.semesterTabTeaching;
      final uniqueSemesterNames = semester.map((e) => e.title).toSet().toList();
      final formInputScore = state.formInputScore;
      return BackGroundContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ScreenAppBar(
              title: widget.listClassScore.classTitle,
              canGoback: true,
              onBack: () {
                Navigator.of(context).pop();
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
                  isLoading: state.status == ScoreStatus.loadingFormScore,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                          18,
                          16,
                          18,
                          12,
                        ),
                        child: DropdownButtonComponent(
                          optionList: uniqueSemesterNames,
                          hint: 'Chọn học kỳ',
                          selectedOption: _selectedOption,
                          onUpdateOption: (value) {
                            final selectedSemester = semester.firstWhere(
                                (semester) => semester.title == value);
                            onUpdateTerm(selectedSemester);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.lightBlue,
                                AppColors.white,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ClassScoreTab(
                            formInputScore: formInputScore,
                          ),
                        ),
                      )
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
