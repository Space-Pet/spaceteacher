import 'package:core/data/models/form_score_esl.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';

class InputScoreESL extends StatelessWidget {
  const InputScoreESL({
    Key? key,
    required this.formScoreESL,
    required this.classScore,
    required this.learnYear,
    required this.semester,
    required this.markTypeColumn,
    required this.onTap,
  }) : super(key: key);

  final List<FormScoreESL> formScoreESL;
  final ClassScore classScore;
  final int semester;
  final String learnYear;
  final MarkTypeColumn markTypeColumn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.laodingPostMOET) {
            LoadingDialog.show(context);
          } else if (state.status == Status.successPostMOET) {
            LoadingDialog.hide(context);
            onTap();
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
        child: InputScoreESLView(
          formScoreESL: formScoreESL,
          classScore: classScore,
          semester: semester,
          learnYear: learnYear,
          markTypeColumn: markTypeColumn,
        ),
      ),
    );
  }
}

class InputScoreESLView extends StatefulWidget {
  const InputScoreESLView({
    Key? key,
    required this.formScoreESL,
    required this.classScore,
    required this.learnYear,
    required this.semester,
    required this.markTypeColumn,
  }) : super(key: key);

  final List<FormScoreESL> formScoreESL;
  final ClassScore classScore;
  final int semester;
  final String learnYear;
  final MarkTypeColumn markTypeColumn;

  @override
  State<InputScoreESLView> createState() => _InputScoreESLViewState();
}

class _InputScoreESLViewState extends State<InputScoreESLView> {
  int currentIndex = 0;
  List<TextEditingController> _controllers = [];
  bool _allFieldsFilled = false;
  final List<JsonDataESL> finalData = [];

  @override
  void initState() {
    super.initState();
    _initControllers();
    _checkAllFieldsFilled();
  }

  void _initControllers() {
    _controllers = widget.formScoreESL[currentIndex].fields.map((field) {
      return TextEditingController(text: field.inputValue);
    }).toList();
  }

  void _clearControllers() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  void _checkAllFieldsFilled() {
    bool allFilled =
        _controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _allFieldsFilled = allFilled;
    });
  }

  void _saveScores(bool isSaveFinal) {
    final List<JsonDataESL> jsonDataList = widget.formScoreESL.map((student) {
      return JsonDataESL(
        classId: widget.classScore.classId.toString(),
        fields: student.fields,
        learnYear: widget.learnYear,
        pupilId: student.pupilId,
        semester: widget.semester.toString(),
        subjectId: widget.classScore.subjectId.toString(),
      );
    }).toList();
    if (isSaveFinal) {
      finalData.addAll(jsonDataList);
    }

    print('All JSON Data:');
    for (var data in jsonDataList) {
      print('${data.fields.first.inputValue}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.formScoreESL[currentIndex];
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
      builder: (context, state) {
        return BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: widget.markTypeColumn.value == 'score'
                    ? 'Nhập điểm'
                    : 'Nhập GPA',
                canGoback: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          student.pupilImage.mobile.isNotEmpty
                              ? student.pupilImage.mobile
                              : 'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                          errorBuilder: (BuildContext context,
                              Object? exception, StackTrace? stackTrace) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lớp ${widget.classScore.classTitle}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${currentIndex + 1}/${widget.formScoreESL.length}',
                                    style: const TextStyle(
                                      color: AppColors.brand600,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    student.pupilName,
                                    style: const TextStyle(
                                      color: AppColors.brand600,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    student.pupilId.toString(),
                                    style: const TextStyle(
                                      color: AppColors.gray400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  student.fields.length,
                                  (index) {
                                    final item = student.fields[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.label,
                                          style: AppTextStyles.normal14(
                                            color: AppColors.brand600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.gray300,
                                                width: 1,
                                              ),
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: TextField(
                                            keyboardType:
                                                const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                            inputFormatters:
                                                widget.markTypeColumn.value ==
                                                        'score'
                                                    ? [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^\d*\.?\d{0,3}')),
                                                        LengthLimitingTextInputFormatter(
                                                            6),
                                                      ]
                                                    : null,
                                            controller: _controllers[index],
                                            maxLines: null,
                                            onChanged: (value) {
                                              setState(() {
                                                item.inputValue = value;
                                              });
                                              _checkAllFieldsFilled();
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  widget.markTypeColumn.value ==
                                                          'score'
                                                      ? 'Nhập điểm'
                                                      : index == 0
                                                          ? 'Nhập điểm'
                                                          : 'Nhập nhận xét',
                                            ),
                                            style: AppTextStyles.normal14(
                                                color: AppColors.gray600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.brand500,
                                    ),
                                    onPressed: _allFieldsFilled
                                        ? () {
                                            if (currentIndex <
                                                widget.formScoreESL.length -
                                                    1) {
                                              setState(() {
                                                _saveScores(false);
                                                currentIndex++;
                                                _initControllers();
                                              });
                                            } else {
                                              _saveScores(true);
                                              context
                                                  .read<ClassScoreBloc>()
                                                  .add(
                                                    PostEslGpa(
                                                      classId: widget
                                                          .classScore.classId,
                                                      dataESL: finalData,
                                                      learnYear:
                                                          widget.learnYear,
                                                      semester: widget.semester,
                                                    ),
                                                  );
                                            }
                                          }
                                        : null,
                                    child: Text(
                                      currentIndex <
                                              widget.formScoreESL.length - 1
                                          ? 'Tiếp theo'
                                          : 'Hoàn thành',
                                      style: AppTextStyles.normal14(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
