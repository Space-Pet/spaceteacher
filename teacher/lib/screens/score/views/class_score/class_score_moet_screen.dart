import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';
import 'package:teacher/screens/score/views/class_score/input_score_moet_high.dart';
import 'package:teacher/screens/score/views/class_score/input_score_student.dart';
import 'package:teacher/screens/score/views/class_score/widgets/class_score_tab.dart';

class ClassScoreMoetScreen extends StatelessWidget {
  const ClassScoreMoetScreen({
    super.key,
    required this.learnYear,
    required this.listClassScore,
  });
  final ClassScore listClassScore;
  final String learnYear;

  static const String routeName = '/class-score';

  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(ScoreSemesterListClass(
        capDaoTao: listClassScore.capDaoTao, subjectType: 'moet'));
    if (listClassScore.capDaoTao == 'C_003') {
      scoreBloc.add(GetMoetPrimary(
        capDaoTao: listClassScore.capDaoTao,
        classId: listClassScore.classId.toString(),
        learnYear: learnYear,
        semester: '1',
        subjectId: listClassScore.subjectId.toString(),
      ));
    } else {
      scoreBloc.add(GetMoetHigh(
        classId: listClassScore.classId.toString(),
        learnYear: learnYear,
        semester: '1',
        subjectId: listClassScore.subjectId.toString(),
      ));
    }
    scoreBloc.add(GetMarkType(
        capDaoTao: listClassScore.capDaoTao,
        classId: listClassScore.classId,
        subjectType: listClassScore.value));

    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.successGetMoet) {
            scoreBloc
                .add(GetStudentInputScore(classId: listClassScore.classId));
          } else if (state.status == Status.updateTerm) {
            if (listClassScore.capDaoTao == 'C_003') {
              scoreBloc.add(GetMoetPrimary(
                capDaoTao: listClassScore.capDaoTao,
                classId: listClassScore.classId.toString(),
                learnYear: learnYear,
                semester: state.termType.value.toString(),
                subjectId: listClassScore.subjectId.toString(),
              ));
            } else {
              scoreBloc.add(GetMoetHigh(
                classId: listClassScore.classId.toString(),
                learnYear: learnYear,
                semester: state.termType.value.toString(),
                subjectId: listClassScore.subjectId.toString(),
              ));
            }
          }
        },
        child: ClassScoreView(
          listClassScore: listClassScore,
          learnYear: learnYear,
        ),
      ),
    );
  }
}

class ClassScoreView extends StatefulWidget {
  const ClassScoreView({
    super.key,
    required this.listClassScore,
    required this.learnYear,
  });
  final ClassScore listClassScore;
  final String learnYear;
  @override
  State<ClassScoreView> createState() => ClassScoreViewState();
}

class ClassScoreViewState extends State<ClassScoreView> {
  String _selectedOption = 'Học kỳ 1';
  @override
  void initState() {
    super.initState();
    if (widget.listClassScore.capDaoTao == 'C_003') {
      _selectedOption = 'Giữa học kỳ 1';
    } else {
      _selectedOption = 'Học kỳ 1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
        builder: (context, state) {
      final scoreBloc = context.read<ClassScoreBloc>();
      final semester = state.semesterTabTeaching;
      final uniqueSemesterNames = semester.map((e) => e.title).toSet().toList();
      final dataMoet = state.dataMoet;
      final dataMoetHigh = state.moetHighData;
      return BackGroundContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ScreenAppBar(
              title: widget.listClassScore.classTitle,
              canGoback: true,
              onBack: () {
                Navigator.of(context).pop();
              },
              hasUpdateYear: true,
              iconWidget: GestureDetector(
                onTap: () {
                  if (widget.listClassScore.capDaoTao == 'C_003') {
                    context.push(InputScoreStudentScreen(
                        learnYear: widget.learnYear,
                        semester: state.termType,
                        classScore: widget.listClassScore));
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => MarkTypeSelection(
                        markType: state.markType,
                        onSelect: (value) {
                          context.push(InputScoreMoetHighScreen(
                            learnYear: widget.learnYear,
                            onTap: () {
                              scoreBloc.add(GetMoetHigh(
                                classId:
                                    widget.listClassScore.classId.toString(),
                                learnYear: widget.learnYear,
                                semester: state.termType.value.toString(),
                                subjectId:
                                    widget.listClassScore.subjectId.toString(),
                              ));
                            },
                            markTypeColumn: value,
                            classScore: widget.listClassScore,
                            semester: state.termType,
                          ));
                        },
                      ),
                    );
                  }
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
                        'Nhập điểm',
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
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
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.lightBlue,
                              AppColors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ClassScoreTab(
                          moetHighData: dataMoetHigh,
                          classScore: widget.listClassScore,
                          dataMoet: dataMoet,
                        ),
                      ),
                    )
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

class MarkTypeSelection extends StatefulWidget {
  final List<MarkTypeColumn> markType;
  final Function(MarkTypeColumn value) onSelect;

  MarkTypeSelection({
    required this.markType,
    required this.onSelect,
  });

  @override
  _MarkTypeSelectionState createState() => _MarkTypeSelectionState();
}

class _MarkTypeSelectionState extends State<MarkTypeSelection> {
  int? selectedIndex;
  MarkTypeColumn? select;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap:
                  true, // Ensures the ListView takes only the necessary height
              itemCount: widget.markType.length,
              itemBuilder: (context, index) {
                final item = widget.markType[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.label),
                      Checkbox(
                        value: selectedIndex == index,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = value! ? index : null;
                            select = item;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (select != null) {
                    Navigator.of(context).pop();
                    widget.onSelect(select!);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Vui lòng chọn cột điểm',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.black,
                        textColor: AppColors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(6),
                  backgroundColor: const Color(0xFF9C292E),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
