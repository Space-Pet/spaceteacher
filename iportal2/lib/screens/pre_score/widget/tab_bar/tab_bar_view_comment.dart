import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:iportal2/screens/pre_score/widget/Component/badge_pre_school.dart';
import 'package:iportal2/screens/pre_score/widget/Component/feedback_group.dart';
import 'package:iportal2/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';
import 'package:skeletons/skeletons.dart';

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
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ),
          )),
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
