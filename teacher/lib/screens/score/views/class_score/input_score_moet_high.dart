import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';

class InputScoreMoetHighScreen extends StatelessWidget {
  final MarkTypeColumn markTypeColumn;
  final ClassScore classScore;
  final Semester semester;
  final VoidCallback onTap;
  final String learnYear;
  const InputScoreMoetHighScreen({
    Key? key,
    required this.markTypeColumn,
    required this.classScore,
    required this.semester,
    required this.onTap,
    required this.learnYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(GetFormMoet(
      classId: classScore.classId,
      learnYear: learnYear,
      semester: semester.value.toString(),
      subjectId: classScore.subjectId,
    ));
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.laodingPostMOET) {
            LoadingDialog.show(context);
          } else if (state.status == Status.failPostMOET) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message,
                timeInSecForIosWeb: 3,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.status == Status.successPostMOET) {
            print('oki');
            LoadingDialog.hide(context);
            context.pop();
            onTap();
          }
        },
        child: InputScoreMoetHighView(
          markTypeColumn: markTypeColumn,
          classScore: classScore,
          semester: semester,
        ),
      ),
    );
  }
}

class InputScoreMoetHighView extends StatefulWidget {
  final MarkTypeColumn markTypeColumn;
  final ClassScore classScore;
  final Semester semester;
  const InputScoreMoetHighView({
    Key? key,
    required this.markTypeColumn,
    required this.classScore,
    required this.semester,
  }) : super(key: key);

  @override
  _InputScoreMoetHighViewState createState() => _InputScoreMoetHighViewState();
}

class _InputScoreMoetHighViewState extends State<InputScoreMoetHighView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
      builder: (context, state) {
        final List<ItemsFormMoet> students = state.formMoet.itemsFormMoet;

        return BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Nhập điểm',
                canGoback: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
              AppSkeleton(
                isLoading: state.status == Status.loadingGetFormMoet,
                child: Expanded(
                  child: Column(
                    children: [
                      if (students.isNotEmpty)
                        ViewInputScore(
                          semester: widget.semester,
                          currentStudent: students,
                          widget: widget,
                          markTypeColumn: widget.markTypeColumn,
                          classScore: widget.classScore,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ViewInputScore extends StatefulWidget {
  const ViewInputScore({
    super.key,
    required this.currentStudent,
    required this.widget,
    required this.markTypeColumn,
    required this.classScore,
    required this.semester,
  });

  final List<ItemsFormMoet> currentStudent;
  final InputScoreMoetHighView widget;
  final MarkTypeColumn markTypeColumn;
  final ClassScore classScore;
  final Semester semester;
  @override
  State<ViewInputScore> createState() => _ViewInputScoreState();
}

class _ViewInputScoreState extends State<ViewInputScore> {
  late List<JsonDataMoet> studentScores;
  int currentIndex = 0;
  String note = 'null';
  @override
  void initState() {
    super.initState();

    studentScores = widget.currentStudent.map((student) {
      return JsonDataMoet(
        pupilId: student.pupilId,
        markType: widget.markTypeColumn.value.toString(),
        markCoefficient: widget.markTypeColumn.value.toString(),
        markValue: '0',
        markNote: note,
      );
    }).toList();
  }

  void nextStudent() {
    setState(() {
      // Save current score input
      studentScores[currentIndex].markValue = studentScoreController.text;
      studentScores[currentIndex].markNote = commentController.text;

      if (currentIndex < widget.currentStudent.length - 1) {
        currentIndex++;
        // Update text controllers for next student
        studentScoreController.text =
            studentScores[currentIndex].markValue.toString();
        commentController.text = studentScores[currentIndex].markNote;
      }
    });
  }

  void previousStudent() {
    setState(() {
      // Save current score input
      studentScores[currentIndex].markValue = studentScoreController.text;
      studentScores[currentIndex].markNote = commentController.text;

      if (currentIndex > 0) {
        currentIndex--;
        // Update text controllers for previous student
        studentScoreController.text =
            studentScores[currentIndex].markValue.toString();
        commentController.text = studentScores[currentIndex].markNote;
      }
    });
  }

  final TextEditingController studentScoreController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Ensure currentIndex is within bounds
    if (currentIndex < 0 || currentIndex >= widget.currentStudent.length) {
      return const Center(
        child: Text('No students available'),
      );
    }

    final item = widget.currentStudent[currentIndex];
    studentScoreController.text =
        studentScores[currentIndex].markValue.toString();
    commentController.text = studentScores[currentIndex].markNote;

    return Expanded(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                item.pupilImage.mobile.isNotEmpty
                    ? item.pupilImage.mobile
                    : 'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                errorBuilder: (BuildContext context, Object? exception,
                    StackTrace? stackTrace) {
                  return Image.network(
                    'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lớp ${widget.widget.classScore.classTitle}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${currentIndex + 1}/${widget.currentStudent.length}',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.pupilName,
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          item.pupilId.toString(),
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Điểm kiểm tra định kỳ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: TextField(
                        controller: studentScoreController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập điểm',
                        ),
                        onChanged: (value) {
                          studentScores[currentIndex].markValue = value;
                        },
                      ),
                    ),
                    if (widget.markTypeColumn.label != 'Kiểm tra thường xuyên')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nhận xét',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: 'Nhập nhận xét',
                              ),
                              onChanged: (value) {
                                studentScores[currentIndex].markNote = value;
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (currentIndex < widget.currentStudent.length - 1)
                    ElevatedButton(
                      onPressed: nextStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand500,
                      ),
                      child: const Text(
                        'Tiếp theo',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (currentIndex == widget.currentStudent.length - 1)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand500,
                      ),
                      onPressed: () {
                        context.read<ClassScoreBloc>().add(PostMoetHigh(
                              classId: widget.classScore.classId,
                              data: studentScores,
                              semester: widget.semester.value.toString(),
                              subjectId: widget.classScore.subjectId,
                            ));
                      },
                      child: const Text(
                        'Hoàn tất',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
