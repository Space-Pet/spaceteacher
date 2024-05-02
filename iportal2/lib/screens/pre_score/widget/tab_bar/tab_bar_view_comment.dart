import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/screens/pre_score/widget/Component/badge_pre_school.dart';
import 'package:iportal2/screens/pre_score/widget/Component/feedback_group.dart';
import 'package:iportal2/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';

class TabBarViewComment extends StatefulWidget {
  const TabBarViewComment(
      {super.key, this.comment, this.endDate, this.startDate});
  final Comment? comment;
  final DateTime? endDate;
  final DateTime? startDate;
  @override
  State<TabBarViewComment> createState() => _TabBarViewCommentState();
}

class _TabBarViewCommentState extends State<TabBarViewComment> {
  @override
  Widget build(BuildContext context) {
    print('img: ${widget.comment?.huyHieuImg}');
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              child: SelectFeedBackType(
                comment: widget.comment,
                endDate: widget.endDate,
                startDate: widget.startDate,
              )),
          if (widget.comment?.huyHieuImg != '')
            Image.network(
              widget.comment?.huyHieuImg ?? '',
              fit: BoxFit.cover,
            ),
          if (widget.comment?.huyHieuImg == '')
            const Center(
              child: EmptyScreen(text: 'Bạn chưa có nhận xét'),
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
    );
  }
}
