// ignore_for_file: file_names

import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/tab_bar/tab_bar_pre_score.dart';
import 'package:repository/repository.dart';

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
      inputStartDate:
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
      inputEndDate: DateTime.now()
          .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday)),
    ));

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
                child: TabBarPreScore(
                  comment: comment ?? [Comment.empty()],
                  endDate: endDate,
                  startDate: startDate,
                  state: state,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
