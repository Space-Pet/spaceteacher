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
import 'package:teacher/screens/score/views/class_score/primary_conduct.dart/input_score_conduct.dart';

class ClassScoreConductScreen extends StatelessWidget {
  const ClassScoreConductScreen({
    super.key,
    required this.phoneBookStudent,
    required this.listClassLeader,
    required this.learnYear,
  });
  final List<PhoneBookStudent> phoneBookStudent;
  final ListClassLeader listClassLeader;
  final String learnYear;
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc
        .add(ScoreSemesterListClass(capDaoTao: 'C_003', subjectType: 'moet'));
    return BlocProvider.value(
      value: scoreBloc,
      child: ClassScoreConductView(
        phoneBookStudent: phoneBookStudent,
        listClassLeader: listClassLeader,
        learnYear: learnYear,
      ),
    );
  }
}

class ClassScoreConductView extends StatefulWidget {
  const ClassScoreConductView({
    super.key,
    required this.phoneBookStudent,
    required this.listClassLeader,
    required this.learnYear,
  });
  final List<PhoneBookStudent> phoneBookStudent;
  final ListClassLeader listClassLeader;
  final String learnYear;

  @override
  State<ClassScoreConductView> createState() => _ClassScoreConductViewState();
}

class _ClassScoreConductViewState extends State<ClassScoreConductView> {
  String _selectedOption = 'Giữa học kỳ 1';
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
      builder: (context, state) {
        final semester = state.semesterTabTeaching;
        final uniqueSemesterNames =
            semester.map((e) => e.title).toSet().toList();
        String txtHocKy = '';
        switch (state.termType.value) {
          case 1:
          case 2:
          case 0:
            txtHocKy = '1';
            break;
          case 3:
          case 4:
            txtHocKy = '2';
            break;
        }
        final conduct = state.primaryConduct.data;
        final listEvaluationNLCL = [
          [...conduct.nangLucCotLoi.nangLucChung],
          [...conduct.nangLucCotLoi.nangLucDacThu],
        ];
        final listEvaluation = [...conduct.phamChatChuYeu];

        return BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: widget.listClassLeader.classCnData.first.className,
                canGoback: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
                hasUpdateYear: true,
                iconWidget: GestureDetector(
                  onTap: () {
                    context.push(
                      InputScoreConduct(
                          onTap: () {
                            context.pop();
                          },
                          learnYear: widget.learnYear,
                          hocKy: int.parse(txtHocKy),
                          hocKyTih: state.termType.value != 0
                              ? state.termType.value
                              : 1,
                          phoneBookStudent: widget.phoneBookStudent),
                    );
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
                          'Nhập hạnh kiểm',
                          style: AppTextStyles.normal14(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Assets.icons.addMessage.svg(height: 20),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(
                            12,
                            16,
                            12,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            widget.phoneBookStudent.length,
                            (index) {
                              final item = widget.phoneBookStudent[index];
                              return Container(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _expandedIndex =
                                                _expandedIndex == index
                                                    ? null
                                                    : index;
                                          });
                                          if (_expandedIndex == index) {
                                            context.read<ClassScoreBloc>().add(
                                                  GetPrimaryConduct(
                                                    hkTihValue: state.termType
                                                                .value !=
                                                            0
                                                        ? state.termType.value
                                                            .toString()
                                                        : '1',
                                                    learnYaer: widget.learnYear,
                                                    txtHocKy: txtHocKy,
                                                    userKey: item.userKey,
                                                  ),
                                                );
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  item.fullName,
                                                  style:
                                                      AppTextStyles.semiBold14(
                                                    color: AppColors.brand600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      item.pupilId.toString(),
                                                      style: AppTextStyles
                                                          .normal14(
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
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
                                        ),
                                      ),
                                    ),
                                    if (_expandedIndex != null &&
                                        _expandedIndex == index)
                                      AppSkeleton(
                                        isLoading: state.status ==
                                            Status.loadingPrimaryConduct,
                                        child: ViewConduct(
                                          listEvaluationNLCL:
                                              listEvaluationNLCL,
                                          listEvaluation: listEvaluation,
                                          conduct: conduct,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
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

class ViewConduct extends StatelessWidget {
  const ViewConduct({
    super.key,
    required this.listEvaluationNLCL,
    required this.listEvaluation,
    required this.conduct,
  });

  final List<List<ConductItem>> listEvaluationNLCL;
  final List<ConductItem> listEvaluation;
  final ConductData conduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              colors: [
                Color(0xFF78B6FF),
                Color(0xFF70B8FF),
              ],
              stops: [
                0.0189,
                0.9356,
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: const Color(0xFF278BEB),
                      child: SvgPicture.asset(
                        'assets/icons/emoji-normal.svg',
                        height: 12,
                        width: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Năng lực cốt lõi',
                      style: AppTextStyles.semiBold14(color: AppColors.white),
                    )
                  ],
                ),
              ),
              Column(
                children: List.generate(listEvaluationNLCL.length, (index) {
                  final itemNLCL = listEvaluationNLCL[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index == 0 ? 'Năng lực chung' : 'Năng lực đặc thù',
                            style:
                                AppTextStyles.bold16(color: AppColors.brand600),
                          ),
                          Column(
                            children: List.generate(itemNLCL.length, (index) {
                              final contentNLCL = itemNLCL[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          contentNLCL.hanhKiemName,
                                          style: AppTextStyles.normal12(
                                            color: AppColors.gray700,
                                          ),
                                        ),
                                        Text(
                                          contentNLCL.hanhKiemValue ?? '',
                                          style: AppTextStyles.normal12(
                                            color: AppColors.brand600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              colors: [
                Color(0xFF6CDAA6),
                Color(0xFF71E0AB),
              ],
              stops: [
                0.0189,
                0.9356,
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: const Color.fromRGBO(41, 177, 29, 1),
                      child: SvgPicture.asset(
                        'assets/icons/emoji-normal.svg',
                        height: 12,
                        width: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Phẩm chất chủ yếu',
                      style: AppTextStyles.semiBold14(color: AppColors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: List.generate(listEvaluation.length, (index) {
                      final itemPCCY = listEvaluation[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemPCCY.hanhKiemName,
                              style: AppTextStyles.normal12(
                                color: AppColors.gray700,
                              ),
                            ),
                            Text(
                              itemPCCY.hanhKiemValue ?? '',
                              style: AppTextStyles.normal12(
                                color: AppColors.brand600,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFEF0C7),
                Color(0xFFFEF0C7),
              ],
              stops: [
                0.0189,
                0.9356,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xFFFFC07A),
                    child: SvgPicture.asset(
                      'assets/icons/emoji-normal.svg',
                      height: 12,
                      width: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Nhận xét của giáo viên',
                    style: AppTextStyles.semiBold14(color: AppColors.brand600),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  conduct.nhanXetChungCuaGvcn?.isNotEmpty ?? false
                      ? conduct.nhanXetChungCuaGvcn?.first.hanhKiemValue ?? ''
                      : '',
                  style: AppTextStyles.normal14(
                    color: AppColors.brand600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
