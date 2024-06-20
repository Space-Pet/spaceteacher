import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/pre_score/add_pre_score.dart';
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
    preScoreBloc.add(GetArmorial());
    preScoreBloc.add(GetComment(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        txtDate: DateTime.now().ddMMyyyyDash,
        userKey: phoneBookStudent.userKey));
    return BlocProvider.value(
        value: preScoreBloc,
        child: BlocListener<PreScoreBloc, PreScoreState>(
          listener: (context, state) {
            if (state.preScoreStatus == PreScoreStatus.loadingPostComment) {
              LoadingDialog.show(context);
            } else if (state.preScoreStatus ==
                PreScoreStatus.successPostComment) {
              LoadingDialog.hide(context);
              preScoreBloc.add(GetComment(
                  startDate: state.startDate,
                  endDate: state.endDate,
                  txtDate: state.startDate.ddMMyyyyDash,
                  userKey: phoneBookStudent.userKey));
            }
          },
          child: TabBarViewCommentView(
            phoneBookStudent: phoneBookStudent,
          ),
        ));
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
  TextEditingController note = TextEditingController();
  Armorial? armorialSelect;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final comments = state.comment;
      final startDate = state.startDate;
      final endDate = state.endDate;
      final armorial = state.armorial;
      final userData = state.userData;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: AppSkeleton(
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
                      if (edit == false) ViewScorePre(comments: comments),
                      if (edit == true)
                        EditScorePre(
                          onNote: (value) {
                            note.text = value;
                          },
                          onSelectArmorial: (value) {
                            armorialSelect = value;
                          },
                          armorial: armorial,
                          phoneBookStudent: widget.phoneBookStudent,
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
                                style: AppTextStyles.semiBold14(
                                    color: Colors.white),
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
                                    context.read<PreScoreBloc>().add(
                                          PostComment(
                                            commentMnContent: note.text,
                                            commentMnTitle:
                                                startDate.toString(),
                                            huyHieuId: armorialSelect?.huyHieuId
                                                    .toString() ??
                                                '',
                                            pupilId:
                                                widget.phoneBookStudent.pupilId,
                                            userKey: context
                                                .read<CurrentUserBloc>()
                                                .state
                                                .user
                                                .user_key,
                                            weekDay: startDate.ddMMyyyyDash,
                                          ),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(6),
                                    backgroundColor: const Color(0xFF9C292E),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
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
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
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
        ),
      );
    });
  }
}

class ViewScorePre extends StatelessWidget {
  ViewScorePre({
    super.key,
    required this.comments,
  });
  final List<Comment> comments;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          comments.first.huyHieuImg ??
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
      ],
    );
  }
}

class EditScorePre extends StatelessWidget {
  EditScorePre({
    super.key,
    required this.armorial,
    required this.phoneBookStudent,
    required this.onSelectArmorial,
    required this.onNote,
  });
  final List<Armorial> armorial;
  final PhoneBookStudent phoneBookStudent;
  final Function(Armorial? arimorial) onSelectArmorial;
  final Function(String note) onNote;
  @override
  Widget build(BuildContext context) {
    TextEditingController note = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.icons.features.report,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  'Nhận xét của giáo viên',
                  style: AppTextStyles.normal16(
                    fontWeight: FontWeight.w600,
                    color: AppColors.brand600,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.white,
                  width: 1,
                ),
              ),
              child: TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    labelText: 'Nhập nhận xét'),
                maxLines: null,
                onChanged: (value) {
                  note.text = value;
                  onNote(note.text);
                },
              ),
            ),
          ),
          DropDowArmorial(
            onTapSelect: (value) {
              onSelectArmorial(value);
            },
            armorial: armorial,
          ),
        ],
      ),
    );
  }
}
