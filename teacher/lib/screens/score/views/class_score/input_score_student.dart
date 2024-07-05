import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';

class InputScoreStudentScreen extends StatelessWidget {
  const InputScoreStudentScreen({
    super.key,
    required this.classScore,
    required this.semester,
    required this.learnYear,
  });
  final ClassScore classScore;
  final Semester semester;
  final String learnYear;
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(GetMoetPrimary(
      capDaoTao: classScore.capDaoTao,
      classId: classScore.classId.toString(),
      learnYear: learnYear,
      semester: semester.value.toString(),
      subjectId: classScore.subjectId.toString(),
    ));
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.laodingPostMOET) {
            LoadingDialog.show(context);
          } else if (state.status == Status.successPostMOET) {
            LoadingDialog.hide(context);
            scoreBloc.add(GetMoetPrimary(
              capDaoTao: classScore.capDaoTao,
              classId: classScore.classId.toString(),
              learnYear: learnYear,
              semester: semester.value.toString(),
              subjectId: classScore.subjectId.toString(),
            ));
          } else if (state.status == Status.successGetMoet) {
            scoreBloc.add(GetStudentInputScore(classId: classScore.classId));
          } else if (state.status == Status.failPostMOET) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          }
        },
        child: InputScoreStudentView(
          classScore: classScore,
          semester: semester,
        ),
      ),
    );
  }
}

class InputScoreStudentView extends StatefulWidget {
  const InputScoreStudentView(
      {super.key, required this.classScore, required this.semester});
  final ClassScore classScore;
  final Semester semester;
  @override
  State<InputScoreStudentView> createState() => _InputScoreStudentViewState();
}

class _InputScoreStudentViewState extends State<InputScoreStudentView> {
  String? selectedValue;
  String? markValue;
  String? markType;
  String? markNote;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
      builder: (context, state) {
        final listStudent = state.phoneBookStudent;
        final numberInputScore = state.numberInputScore;

        return BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Nhập điểm',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: AppSkeleton(
                    isLoading: (state.status == Status.loadingGetMoet) ||
                        (state.status == Status.loadingGetStudent),
                    child: Column(
                      children: [
                        Image.network(
                          listStudent.urlImage.mobile?.isNotEmpty == true
                              ? listStudent.urlImage.mobile!
                              : 'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.network(
                                'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg');
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lớp ${listStudent.className}',
                                        style: AppTextStyles.normal12(
                                          color: AppColors.gray700,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        numberInputScore,
                                        style: AppTextStyles.normal14(
                                          color: AppColors.brand600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        listStudent.fullName,
                                        style: AppTextStyles.normal16(
                                          color: AppColors.brand600,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        listStudent.userKey,
                                        style: AppTextStyles.normal14(
                                          color: AppColors.brand600,
                                          fontWeight: FontWeight.w600,
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
                                    color: AppColors.gray300,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Mức đạt được*',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: AppColors.gray300, width: 1),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedValue,
                                      hint: const Text('--Chọn mức đạt được--'),
                                      items: <String>[
                                        'Hoàn thành tốt (T)',
                                        'Hoàn thành (H)',
                                        'Chưa hoàn thành (C)'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue = newValue;
                                          if (newValue ==
                                              'Hoàn thành tốt (T)') {
                                            markType = 'T';
                                          } else if (newValue ==
                                              'Hoàn thành (H)') {
                                            markType = 'H';
                                          } else if (newValue ==
                                              'Chưa hoàn thành (C)') {
                                            markType = 'C';
                                          }
                                        });
                                        print('masd: $markType');
                                      },
                                      underline: const SizedBox.shrink(),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Điểm kiểm tra định kỳ',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TitleAndInputText(
                                      hintText: 'Nhập điểm',
                                      onChanged: (value) {
                                        markValue = value;
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Nhậm xét',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TitleAndInputText(
                                      hintText: 'Nhập nhận xét',
                                      onChanged: (value) {
                                        markNote = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ClassScoreBloc>()
                                            .add(PostMOETPrimary(
                                              classId:
                                                  widget.classScore.classId,
                                              markNote: markNote,
                                              markType: markType ?? '',
                                              markValue: markValue,
                                              pupilId: listStudent.pupilId,
                                              semester: widget.semester.value
                                                  .toString(),
                                              subjectId:
                                                  widget.classScore.subjectId,
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(6),
                                        backgroundColor:
                                            const Color(0xFF9C292E),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(
                                          'Tiếp theo',
                                          style: AppTextStyles.semiBold14(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(6),
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(
                                          'Quay lại',
                                          style: AppTextStyles.semiBold14(
                                              color: Color(0xFF9C292E)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
