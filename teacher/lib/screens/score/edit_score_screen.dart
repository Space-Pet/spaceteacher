import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/widgets/esl/esl_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view.dart';
import 'package:teacher/screens/score/widgets/moet/moet_view_primary.dart';
import 'package:teacher/screens/score/widgets/score_filter.dart';
import 'package:repository/repository.dart';

class EditScoreScreen extends StatelessWidget {
  const EditScoreScreen({
    super.key,
    required this.phoneBookStudent,
    required this.learnYear,
  });
  static const String routeName = 'scoreEdit';
  final PhoneBookStudent phoneBookStudent;
  final String learnYear;
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(ScoreFetchProgramList(userKey: phoneBookStudent.userKey));
    scoreBloc.add(ScoreFilterSemester(subjectType: 'moet'));

    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ScoreBloc, ScoreState>(
        listener: (context, state) {
          if (state.status == ScoreStatus.loadingPostComment) {
            LoadingDialog.show(context);
          } else if (state.status == ScoreStatus.successPostComment) {
            LoadingDialog.hide(context);
            scoreBloc.add(
              ScoreFetchMoetAverage(
                learnYear: learnYear,
                txtHocKy: state.termType,
                userkey: phoneBookStudent.userKey,
              ),
            );
          } else if (state.status == ScoreStatus.fail) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.status == ScoreStatus.success) {
            if (state.programList.first.ctName.contains('MOET') &&
                context
                    .read<CurrentUserBloc>()
                    .state
                    .user
                    .cap_dao_tao
                    .id
                    .contains('C_003')) {
              scoreBloc.add(
                ScoreFetchMoetAverage(
                  learnYear: learnYear,
                  txtHocKy: state.termType,
                  userkey: phoneBookStudent.userKey,
                ),
              );
              scoreBloc.add(
                ScoreFetchMoetType(
                  isMOETCheck: state.isMOET.contains('MOET'),
                  ctId: state.ctId,
                  learnYear: learnYear,
                  txtHocKy: state.termType.toString(),
                  userKey: phoneBookStudent.userKey,
                ),
              );
              scoreBloc.add(ScoreFetchPrimaryConduct(
                  hkTihValue: '1',
                  txtYear: learnYear,
                  txtHocKy: '1',
                  userKey: phoneBookStudent.userKey));
            } else if (state.programList.first.ctId.contains('esl')) {
              scoreBloc.add(GetEslScore(
                userKey: phoneBookStudent.userKey,
                txtTerm: '1',
                txtYear: learnYear,
              ));
            } else {
              scoreBloc.add(
                ScoreFetchMoetAverage(
                  learnYear: learnYear,
                  txtHocKy: state.termType,
                  userkey: phoneBookStudent.userKey,
                ),
              );
              scoreBloc.add(
                ScoreFetchMoetType(
                  isMOETCheck: state.programList.first.ctName.contains('MOET'),
                  ctId: state.programList.first.ctId,
                  learnYear: learnYear,
                  txtHocKy: '1',
                  userKey: phoneBookStudent.userKey,
                ),
              );
            }
          } else if (state.status == ScoreStatus.loadedUpdateProgram) {
            if (!state.isMOET.contains('ESL') &&
                context
                    .read<CurrentUserBloc>()
                    .state
                    .user
                    .cap_dao_tao
                    .id
                    .contains('C_003')) {
              String txtHocKy = '';
              switch (state.termType) {
                case 1 || 2:
                  txtHocKy = '1';
                case 3 || 4:
                  txtHocKy = '2';
                  break;
              }
              scoreBloc.add(
                ScoreFetchMoetAverage(
                  learnYear: learnYear,
                  txtHocKy: state.termType,
                  userkey: phoneBookStudent.userKey,
                ),
              );

              scoreBloc.add(
                ScoreFetchMoetType(
                  isMOETCheck: state.isMOET.contains('MOET'),
                  ctId: state.ctId,
                  learnYear: learnYear,
                  txtHocKy: state.termType.toString(),
                  userKey: phoneBookStudent.userKey,
                ),
              );
              scoreBloc.add(ScoreFetchPrimaryConduct(
                  hkTihValue: state.termType.toString(),
                  txtYear: learnYear,
                  txtHocKy: txtHocKy,
                  userKey: phoneBookStudent.userKey));
            } else if (state.isMOET.contains('ESL')) {
              scoreBloc.add(GetEslScore(
                userKey: phoneBookStudent.userKey,
                txtTerm: state.termType.toString(),
                txtYear: learnYear,
              ));
            } else {
              scoreBloc.add(
                ScoreFetchMoetAverage(
                  learnYear: learnYear,
                  txtHocKy: state.termType,
                  userkey: phoneBookStudent.userKey,
                ),
              );
              scoreBloc.add(
                ScoreFetchMoetType(
                  isMOETCheck: state.isMOET.contains('MOET'),
                  ctId: state.ctId,
                  learnYear: learnYear,
                  txtHocKy: state.termType.toString(),
                  userKey: phoneBookStudent.userKey,
                ),
              );
            }
          }
        },
        child: EditScoreView(
          phoneBookStudent: phoneBookStudent,
          learnYear: learnYear,
        ),
      ),
    );
  }
}

class EditScoreView extends StatelessWidget {
  const EditScoreView({
    super.key,
    required this.phoneBookStudent,
    required this.learnYear,
  });
  final PhoneBookStudent phoneBookStudent;
  final String learnYear;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      final scoreBloc = context.read<ScoreBloc>();
      final scoreData = state.moetScore;
      final eslScore = state.eslScore;
      final programList =
          state.programList; // Ensure programList is retrieved from state

      final isLoading =
          (state.status == ScoreStatus.loadingSemesterLeaderTeacher) ||
              (state.status == ScoreStatus.loadingGetEsl) ||
              (state.status == ScoreStatus.loadingGetMoetOther) ||
              (state.status == ScoreStatus.loadingGetMoetAverage);

      final semester = state.semester;
      final user = state.localTeacher;
      final edit = state.edit;
      final moetAverage = state.moetAverage;
      print('value term: ${state.termType}');

      final termValue = state.termType;
      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScoreAppbar(
              onOpenIcon: () {
                scoreBloc.add(EditScore(edit: !edit));
              },
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
                    AppSkeleton(
                      isLoading: state.status == ScoreStatus.loading,
                      child: ScoreFilter(
                        state: state,
                        semesterList: semester,
                        programList:
                            programList, // Pass programList to ScoreFilter

                        onSelectedOption: (ViewScoreSelectedParam newOption) {
                          String type = state.programList.first.ctId;
                          String isMOET = state.programList.first.ctName;
                          for (var item in programList) {
                            if (item.ctName == newOption.selectedScoreType) {
                              type = item.ctId;
                              isMOET = item.ctName;

                              break;
                            }
                          }

                          scoreBloc.add(ScoreFilterChange(
                            ctId: type,
                            isMOETCheck: isMOET.contains('MOET'),
                            scoreFilter: newOption,
                            type: type,
                            isMOET: isMOET,
                          ));
                        },
                        selectedOption: ViewScoreSelectedParam(
                          selectedScoreType: programList.first.ctName,
                          selectedTerm: semester.first.title,
                          selectedYear: state.txtLearnYear,
                        ),
                      ),
                    ),
                    Expanded(
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
                              child: state.type == 'esl'
                                  ? EslView(
                                      eslScore: eslScore.data,
                                    )
                                  :
                                  // MoetView(
                                  //     isMOET: state.isMOET.contains('MOET'),
                                  //   )
                                  user.cap_dao_tao.id != 'C_003'
                                      ? MoetView(
                                          moetAverage: moetAverage,
                                          onNote: (value) {
                                            context
                                                .read<ScoreBloc>()
                                                .add(PostCommentMoet(
                                                  commnetContent: value,
                                                  hkTihValue:
                                                      state.termType.toString(),
                                                  learnYear: learnYear,
                                                  pupilId:
                                                      phoneBookStudent.pupilId,
                                                  subjectId: 1000,
                                                  userKey:
                                                      phoneBookStudent.userKey,
                                                ));
                                          },
                                          semester: state.termType,
                                          learnYear: learnYear,
                                          phoneBookStudent: phoneBookStudent,
                                          isMOET: state.isMOET.contains('MOET'),
                                        )
                                      : MoetViewPrimary(
                                          onNote: (value) {
                                            context
                                                .read<ScoreBloc>()
                                                .add(PostCommentMoet(
                                                  commnetContent: value,
                                                  hkTihValue:
                                                      state.termType.toString(),
                                                  learnYear: learnYear,
                                                  pupilId:
                                                      phoneBookStudent.pupilId,
                                                  subjectId: 1000,
                                                  userKey:
                                                      phoneBookStudent.userKey,
                                                ));
                                          },
                                          moetAverage: moetAverage,
                                          diemMoetTxt: state.moetScore.txtDiem,
                                          semester: state.termType,
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
    });
  }
}

class ScoreAppbar extends StatelessWidget {
  const ScoreAppbar({
    super.key,
    required this.scoreData,
    required this.selectedOption,
    required this.onOpenIcon,
  });

  final ScoreModel scoreData;
  final String selectedOption;
  final VoidCallback onOpenIcon;

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
            hasUpdateYear:
                context.read<CurrentUserBloc>().state.user.cap_dao_tao.id !=
                        'C_003'
                    ? true
                    : false,
            iconWidget:
                Assets.icons.editProfile.svg(color: AppColors.white, width: 24),
            onOpenIcon: onOpenIcon,
          ),
        ),
      ],
    );
  }
}

class ViewScoreSelectedParam {
  final String selectedYear;
  final String selectedScoreType;
  final String? selectedScoreProgram;
  final String selectedTerm;
  final int valueTerm;

  ViewScoreSelectedParam(
      {required this.selectedYear,
      this.valueTerm = 1,
      required this.selectedScoreType,
      this.selectedScoreProgram,
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
