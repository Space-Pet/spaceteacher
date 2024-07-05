import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';
import 'package:teacher/screens/score/views/class_score/score_esl/input_score_esl.dart';

class ClassScoreESLScreen extends StatelessWidget {
  const ClassScoreESLScreen({
    super.key,
    required this.markTypeColumn,
    required this.learnYear,
    required this.listClassScore,
  });
  final MarkTypeColumn markTypeColumn;

  final ClassScore listClassScore;
  final String learnYear;
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(ScoreSemesterListClass(
        capDaoTao: listClassScore.capDaoTao, subjectType: 'esl'));
    scoreBloc.add(
      GetFormScoreESL(
        classId: listClassScore.classId,
        learnYear: learnYear,
        scoreType: markTypeColumn.value,
        semester: 1,
        subjectId: listClassScore.subjectId,
      ),
    );
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.updateTerm) {
            scoreBloc.add(
              GetFormScoreESL(
                classId: listClassScore.classId,
                learnYear: learnYear,
                scoreType: markTypeColumn.value,
                semester: state.termType.value,
                subjectId: listClassScore.subjectId,
              ),
            );
          }
        },
        child: ClassScoreESlView(
          learnYear: learnYear,
          listClassScore: listClassScore,
          markTypeColumn: markTypeColumn,
        ),
      ),
    );
  }
}

class ClassScoreESlView extends StatefulWidget {
  const ClassScoreESlView({
    super.key,
    required this.learnYear,
    required this.listClassScore,
    required this.markTypeColumn,
  });
  final ClassScore listClassScore;
  final String learnYear;
  final MarkTypeColumn markTypeColumn;
  @override
  State<ClassScoreESlView> createState() => _ClassScoreESlViewState();
}

class _ClassScoreESlViewState extends State<ClassScoreESlView> {
  String _selectedOption = 'Học kỳ 1';
  int? _expandedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
        builder: (context, state) {
      final semester = state.semesterTabTeaching;
      final uniqueSemesterNames = semester.map((e) => e.title).toSet().toList();
      final formESL = state.formScoreESL;
      return BackGroundContainer(
        child: Column(
          children: [
            ScreenAppBar(
              title: widget.listClassScore.classTitle,
              canGoback: true,
              onBack: () {
                Navigator.of(context).pop();
              },
              hasUpdateYear: true,
              iconWidget: GestureDetector(
                onTap: () {
                  context.push(InputScoreESL(
                    onTap: () {
                      context.pop();
                      context.read<ClassScoreBloc>().add(
                            GetFormScoreESL(
                              classId: widget.listClassScore.classId,
                              learnYear: widget.learnYear,
                              scoreType: widget.markTypeColumn.value,
                              semester: state.termType.value,
                              subjectId: widget.listClassScore.subjectId,
                            ),
                          );
                    },
                    markTypeColumn: widget.markTypeColumn,
                    learnYear: widget.learnYear,
                    semester:
                        state.termType.value != 0 ? state.termType.value : 1,
                    formScoreESL: formESL,
                    classScore: widget.listClassScore,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.white,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.markTypeColumn.value == 'score'
                            ? 'Nhập điểm'
                            : 'Nhập GPA',
                        style: AppTextStyles.normal14(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Assets.icons.addMessage.svg(height: 20)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFDFEEFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    AppSkeleton(
                      isLoading: state.status == Status.loadingGetSemester,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(
                          18,
                          16,
                          18,
                          12,
                        ),
                        child: DropdownButtonComponent(
                          optionList: uniqueSemesterNames,
                          hint: 'Chọn học kỳ',
                          selectedOption: _selectedOption,
                          onUpdateOption: (value) {
                            final selectedSemester = semester.firstWhere(
                                (semester) => semester.title == value);
                            context
                                .read<ClassScoreBloc>()
                                .add(UpdateTerm(semester: selectedSemester));
                          },
                        ),
                      ),
                    ),
                    AppSkeleton(
                      isLoading: state.status == Status.loadingGetFormESL,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  formESL.length,
                                  (index) {
                                    final item = formESL[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _expandedIndex =
                                                    _expandedIndex == index
                                                        ? null
                                                        : index;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item.pupilName,
                                                  style: AppTextStyles.normal14(
                                                    color: AppColors.brand600,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      item.pupilId.toString(),
                                                      style: AppTextStyles
                                                          .normal14(
                                                        color:
                                                            AppColors.gray600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Icon(_expandedIndex == index
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (_expandedIndex != null &&
                                              _expandedIndex == index &&
                                              widget.markTypeColumn.value ==
                                                  'score')
                                            ViewESL(item: item),
                                          if (_expandedIndex != null &&
                                              _expandedIndex == index &&
                                              widget.markTypeColumn.value ==
                                                  'gpa')
                                            ViewGPA(item: item),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
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

class ViewESL extends StatelessWidget {
  const ViewESL({
    super.key,
    required this.item,
  });

  final FormScoreESL item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.brand200,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 5,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  item.fields.length,
                  (index) {
                    final itemField = item.fields[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: item.fields.length > index + 1 ? 8 : 0),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.gray300,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemField.label,
                              style: AppTextStyles.normal12(
                                color: AppColors.gray700,
                              ),
                            ),
                            Text(
                              itemField.inputValue ?? '0',
                              style: AppTextStyles.normal12(
                                color: AppColors.brand500,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewGPA extends StatelessWidget {
  const ViewGPA({
    super.key,
    required this.item,
  });

  final FormScoreESL item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.brand200,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 5,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.gray300,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.fields.first.label,
                            style: AppTextStyles.normal12(
                              color: AppColors.gray700,
                            ),
                          ),
                          Text(
                            item.fields.first.inputValue ?? '0',
                            style: AppTextStyles.normal12(
                              color: AppColors.brand500,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.gray100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/conversation-icon.svg',
                              width: 16,
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                item.fields[1].label,
                                style: AppTextStyles.normal14(
                                  color: AppColors.brand600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          item.fields[1].inputValue ?? '',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray700,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.gray100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/conversation-icon.svg',
                              width: 16,
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                item.fields[2].label,
                                style: AppTextStyles.normal14(
                                  color: AppColors.brand600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          item.fields[2].inputValue ?? '',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray700,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
