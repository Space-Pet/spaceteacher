import 'package:core/data/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:iportal2/screens/pre_score/widget/Component/badge_pre_school.dart';
import 'package:iportal2/screens/pre_score/widget/Component/feedback_group.dart';
import 'package:iportal2/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';

class TabBarViewComment extends StatefulWidget {
  const TabBarViewComment(
      {super.key,
      this.comment,
      this.endDate,
      this.startDate,
      required this.state});
  final Comment? comment;
  final DateTime? endDate;
  final DateTime? startDate;
  final PreScoreState state;
  @override
  State<TabBarViewComment> createState() => _TabBarViewCommentState();
}

class _TabBarViewCommentState extends State<TabBarViewComment> {
  @override
  Widget build(BuildContext context) {
    final isLoading = widget.state.preScoreStatus == PreScoreStatus.loading;
    return AppSkeleton(
      isLoading: isLoading,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              child: SelectFeedBackType(
                comment: widget.comment,
                endDate: widget.endDate,
                startDate: widget.startDate,
              )),
          SingleChildScrollView(
            child: Column(
              children: [
                if (widget.comment?.huyHieuImg != '')
                  Image.network(
                    widget.comment?.huyHieuImg ?? '',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                if (widget.comment?.huyHieuImg == '')
                  const Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Center(
                      child: EmptyScreen(text: 'Bạn chưa có nhận xét'),
                    ),
                  ),
                const SizedBox(
                  height: 14,
                ),
                if (widget.comment?.huyHieuName != '')
                  BadgePreSchool(
                    comment: widget.comment,
                  ),
                const SizedBox(
                  height: 14,
                ),
                if (widget.comment?.commentNote != '')
                  FeedbackGroup(
                    comment: widget.comment,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
