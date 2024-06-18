import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/Component/badge_pre_school.dart';
import 'package:teacher/screens/pre_score/widget/Component/feedback_group.dart';
import 'package:teacher/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';

class TabBarViewComment extends StatelessWidget {
  const TabBarViewComment({
    super.key,
    required this.phoneBookStudent,
  });
  final PhoneBookStudent phoneBookStudent;
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    preScoreBloc.add(GetComment(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        txtDate: DateTime.now().ddMMyyyyDash,
        userKey: phoneBookStudent.userKey));
    return BlocProvider.value(
      value: preScoreBloc,
      child: TabBarViewCommentView(
        phoneBookStudent: phoneBookStudent,
      ),
    );
  }
}

class TabBarViewCommentView extends StatefulWidget {
  const TabBarViewCommentView({
    super.key,
    required this.phoneBookStudent,
  });
  final PhoneBookStudent phoneBookStudent;
  @override
  State<TabBarViewCommentView> createState() => _TabBarViewCommentViewState();
}

class _TabBarViewCommentViewState extends State<TabBarViewCommentView> {
  late bool edit = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final comments = state.comment;
      final startDate = state.startDate;
      final endDate = state.endDate;
      return AppSkeleton(
        isLoading: state.preScoreStatus == PreScoreStatus.loadingGetComment,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                child: SelectFeedBackType(
                  onGetComment: (startDate, endDate) {
                    print('start: $startDate - end: $endDate');
                    context.read<PreScoreBloc>().add(GetComment(
                        startDate: startDate,
                        endDate: endDate,
                        txtDate: startDate.ddMMyyyyDash,
                        userKey: widget.phoneBookStudent.userKey));
                  },
                  endDate: endDate,
                  startDate: startDate,
                )),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Image.network(
                      'https://cdn-icons-png.freepik.com/512/9776/9776920.png',
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    BadgePreSchool(
                      comment: comments.first.huyHieuName,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    FeedbackGroup(
                      nameTeacher: comments.first.teacherName,
                      comment: comments.first.commentNote,
                    ),
                    if (edit == false)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              edit = true;
                            });
                            print('$edit');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(6),
                            backgroundColor: const Color(0xFF9C292E),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              'Chỉnh sửa',
                              style:
                                  AppTextStyles.semiBold14(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    if (edit == true)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    edit = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(6),
                                  backgroundColor: const Color(0xFF9C292E),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Lưu',
                                    style: AppTextStyles.semiBold14(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    edit = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(6),
                                  backgroundColor: Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Huỷ',
                                    style: AppTextStyles.semiBold14(
                                        color: const Color(0xFF9C292E)),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
