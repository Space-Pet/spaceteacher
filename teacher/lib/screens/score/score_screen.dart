import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';
import 'package:repository/repository.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';
import 'package:teacher/screens/score/views/class_score/primary_conduct.dart/class_score_conduct_screen.dart';
import 'package:teacher/screens/score/views/class_score/score_esl/class_score_esl_screen.dart';
import 'package:teacher/screens/score/views/class_score/class_score_moet_screen.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  static const String routeName = 'score';
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    final now = DateTime.now().year;
    scoreBloc.add(GetLearnYear());
    scoreBloc.add(GetClassLeader(learnYear: '${now - 1}-${now}'));
    scoreBloc.add(ClassListFetched());
    scoreBloc.add(GetTeacherDetail());

    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ScoreBloc, ScoreState>(
        listener: (context, state) {
          if (state.status == ScoreStatus.successClassLeader) {
            scoreBloc.add(GetListStudent(
                classId:
                    int.parse(state.classLeader.classCnData.first.classId)));
          }
        },
        child: const ScoreView(),
      ),
    );
  }
}

class ScoreView extends StatefulWidget {
  const ScoreView({
    super.key,
  });

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      final scoreBloc = context.read<ScoreBloc>();
      final scoreData = state.moetScore;
      final listClassScore = state.listClassScore;
      final listStudent = state.phoneBookStudent;
      final isLoadingStudent =
          state.status == ScoreStatus.loadingGetListStudent;
      final now = DateTime.now().year;

      String learnYear = '${now - 1}-$now';
      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSkeleton(
              isLoading: state.status == ScoreStatus.loadingLearnYear,
              child: ScoreAppbar(
                learnYear: state.learnYear,
                scoreData: scoreData,
                selectedOption: learnYear,
                onUpdateYear: (value) {
                  learnYear = value;
                  context
                      .read<ScoreBloc>()
                      .add(SelectYear(txtLearnYear: value));
                  print('object: $value');
                },
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
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppColors.white,
                            dividerColor: Colors.transparent,
                            labelPadding: EdgeInsets.zero,
                            indicatorPadding: const EdgeInsets.only(top: -2.5),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: AppTextStyles.semiBold16(
                              color: AppColors.white,
                            ),
                            onTap: (value) {
                              setState(() {
                                _tabController.index = value;
                              });
                            },
                            unselectedLabelStyle: AppTextStyles.semiBold14(
                                color: AppColors.brand600),
                            indicator: const BoxDecoration(
                              color: AppColors.brand600,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            tabs: const [
                              Tab(
                                child: Align(
                                  child: Text(
                                    'Lớp chủ nhiệm',
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  child: Text('Lớp giảng dạy'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AppSkeleton(
                              isLoading: isLoadingStudent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: AppColors.brand600,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: listStudent.length,
                                    itemBuilder: (context, index) {
                                      final item = listStudent[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.push(EditScoreScreen(
                                              phoneBookStudent: item,
                                              learnYear: learnYear,
                                            ));
                                          },
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    AppColors.amberA200,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.fullName,
                                                      style: AppTextStyles
                                                          .normal14(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.brand600,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.pupilId.toString(),
                                                      style: AppTextStyles
                                                          .normal12(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.secondary,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: AppColors.brand600,
                                    width: 0.5,
                                  ),
                                ),
                                child: BlocBuilder<ScoreBloc, ScoreState>(
                                  builder: (context, state) {
                                    return state.status ==
                                            ScoreStatus.loadingFormScore
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, top: 8),
                                                  child: Text(
                                                    'Nhập điểm',
                                                    style:
                                                        AppTextStyles.normal16(
                                                      color: AppColors.brand600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  padding: EdgeInsets.zero,
                                                  child: Column(
                                                    children: listClassScore
                                                        .map((item) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (item.value ==
                                                              'esl') {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (context) =>
                                                                  MarkTypeSelection(
                                                                markType:
                                                                    MarkTypeColumn
                                                                        .fakeDataESL(),
                                                                onSelect:
                                                                    (value) {
                                                                  context.push(
                                                                    ClassScoreESLScreen(
                                                                      markTypeColumn:
                                                                          value,
                                                                      learnYear:
                                                                          learnYear,
                                                                      listClassScore:
                                                                          item,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else {
                                                            context.push(
                                                              ClassScoreMoetScreen(
                                                                learnYear:
                                                                    learnYear,
                                                                listClassScore:
                                                                    item,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              4),
                                                                  child:
                                                                      Expanded(
                                                                    child: Text(
                                                                      item.titel,
                                                                      style: AppTextStyles.normal14(
                                                                          color:
                                                                              AppColors.gray400),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                if (context
                                                        .read<CurrentUserBloc>()
                                                        .state
                                                        .user
                                                        .cap_dao_tao
                                                        .id ==
                                                    'C_003')
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 8),
                                                        child: Text(
                                                          'Nhập hạnh kiểm',
                                                          style: AppTextStyles
                                                              .normal16(
                                                            color: AppColors
                                                                .brand600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 8),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            context.push(
                                                              ClassScoreConductScreen(
                                                                listClassLeader:
                                                                    state
                                                                        .classLeader,
                                                                phoneBookStudent:
                                                                    listStudent,
                                                                learnYear:
                                                                    learnYear,
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            state
                                                                .classLeader
                                                                .classCnData
                                                                .first
                                                                .className,
                                                            style: AppTextStyles
                                                                .normal14(
                                                              color: AppColors
                                                                  .brand600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          );
                                  },
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
            ),
          ],
        ),
      );
    });
  }
}

class ScoreAppbar extends StatelessWidget {
  ScoreAppbar({
    super.key,
    required this.scoreData,
    required this.selectedOption,
    required this.onUpdateYear,
    required this.learnYear,
  });

  final LearnYear learnYear;
  final ScoreModel scoreData;
  String selectedOption;
  final void Function(String newYear) onUpdateYear;

  void _showYearPicker(BuildContext context) {
    final now = DateTime.now().year;
    final years = [
      learnYear.preLearnYear,
      learnYear.currentLearnYear,
      learnYear.nextLearnYear
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: const Text('Chọn năm học'),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: years.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(years[index]),
                      onTap: () {
                        onUpdateYear(years[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      final txtLearnYear = state.txtLearnYear;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ScreenAppBar(
              title: 'Xem điểm',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 16),
            child: GestureDetector(
              onTap: () => _showYearPicker(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gray400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      txtLearnYear,
                      style: AppTextStyles.normal14(color: AppColors.gray600),
                    ),
                    const Icon(Icons.arrow_drop_down, color: AppColors.gray600),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
