import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/screens/comment/bloc/comment_bloc.dart';
import 'package:iportal2/screens/comment/widget/Component/badge_pre_school.dart';
import 'package:iportal2/screens/comment/widget/Component/feedback_group.dart';
import 'package:iportal2/screens/comment/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';

class TabBarViewComment extends StatelessWidget {
  const TabBarViewComment({
    super.key,
    this.comment,
    this.endDate,
    this.startDate,
  });
  final Comment? comment;
  final DateTime? endDate;
  final DateTime? startDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        final isLoading = state.commentStatus == CommentStatus.loading;
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
                child: SelectFeedBackType(
                  comment: comment,
                  endDate: endDate,
                  startDate: startDate,
                )),
            Expanded(
              child: (comment?.huyHieuImg ?? '').isEmpty
                  ? const Center(
                      child: EmptyScreen(text: 'Chưa có dữ liệu'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          isLoading
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(130),
                                  child: Assets.images.avatar.image(
                                      fit: BoxFit.cover,
                                      height: 260,
                                      width: 260),
                                )
                              : Image.network(
                                  comment?.huyHieuImg ?? '',
                                  fit: BoxFit.cover,
                                  height: 260,
                                  width: 260,
                                ),
                          BadgePreSchool(huyHieuName: comment!.huyHieuName),
                          const SizedBox(height: 8),
                          FeedbackGroup(comment: comment)
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
