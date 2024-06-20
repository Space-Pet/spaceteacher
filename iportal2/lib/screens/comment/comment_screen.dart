// ignore_for_file: file_names

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/comment/bloc/comment_bloc.dart';
import 'package:iportal2/screens/comment/widget/tab_bar/tab_bar_comment.dart';
import 'package:repository/repository.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  static const routeName = '/comment';

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = CommentBloc(
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
      child: const CommentView(),
    );
  }
}

class CommentView extends StatefulWidget {
  const CommentView({super.key});
  @override
  State<CommentView> createState() => CommentViewState();
}

class CommentViewState extends State<CommentView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
      final comment = state.comment;
      final startDate = state.startDate;
      final endDate = state.endDate;
      final isLoading = state.commentStatus == CommentStatus.loading;

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
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: TabBarComment(
                    comment: comment ?? [],
                    endDate: endDate,
                    startDate: startDate,
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
