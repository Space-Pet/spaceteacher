import 'package:core/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:iportal2/screens/pre_score/widget/tab_bar/tab_bar_pre_score.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

import '../../resources/app_colors.dart';

class PreScoreScreen extends StatelessWidget {
  const PreScoreScreen({super.key});

  static const routeName = '/pre-score';

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
    preScoreBloc.add(GetComment(
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      startDate:
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
      endDate: DateTime.now()
          .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday)),
    ));
    final currentYear = DateTime.now().year;

    final lastYear = currentYear - 1;

    final learnYear = '$lastYear-$currentYear';

    preScoreBloc.add(GetListReportStudent(learnYear: learnYear));
    return BlocProvider.value(
      value: preScoreBloc,
      child: const StudentScoreViewPre(),
    );
  }
}

class StudentScoreViewPre extends StatefulWidget {
  const StudentScoreViewPre({super.key});
  @override
  State<StudentScoreViewPre> createState() => StudentScoreViewPreState();
}

class StudentScoreViewPreState extends State<StudentScoreViewPre> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final isLoading = state.preScoreStatus == PreScoreStatus.loading;
      final comment = state.comment;
      final startDate = state.startDate;
      final endDate = state.endDate;

      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              title: 'Nhận xét',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
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
                child: AppSkeleton(
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                    child: TabBarPreScore(
                      comment: comment ?? [Comment.empty()],
                      endDate: endDate,
                      startDate: startDate,
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }
}
