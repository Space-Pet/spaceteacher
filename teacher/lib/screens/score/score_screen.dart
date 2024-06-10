import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/score/bloc/score_bloc.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';
import 'package:repository/repository.dart';

class ScoreScreen extends StatefulWidget {
  static const String routeName = 'score';

  const ScoreScreen({
    super.key,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen>
    with TickerProviderStateMixin {
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
    return BlocProvider(
      create: (context) => ScoreBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
        final scoreBloc = context.read<ScoreBloc>();
        final scoreData = state.moetScore;

        final khoiLevel = int.parse(
            scoreData.txtKhoiLevel.isEmpty ? '0' : scoreData.txtKhoiLevel);
        final isPrimary = khoiLevel < 6;

        void onUpdateYear(String newYear) {
          scoreBloc.add(ScoreFilterChange(
            ViewScoreSelectedParam(
              selectedScoreType: state.scoreType,
              selectedTerm:
                  isPrimary ? state.txtTihHocKy.text() : state.txtHocKy.text(),
              selectedYear: newYear,
            ),
            isPrimary,
          ));
        }

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScoreAppbar(
                scoreData: scoreData,
                selectedOption: state.txtLearnYear,
                onUpdateYear: onUpdateYear,
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
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16),
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
                              indicatorPadding:
                                  const EdgeInsets.only(top: -3.5),
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
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.push(EditScoreScreen());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        AppColors.amberA200,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Mel Tran',
                                                          style: AppTextStyles
                                                              .normal14(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .brand600,
                                                          ),
                                                        ),
                                                        Text(
                                                          'GHJKH77834789342',
                                                          style: AppTextStyles
                                                              .normal12(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Assets.icons.vector.svg()
                                            ],
                                          ),
                                        ),
                                      );
                                    },
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
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 8,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.gray100),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.gray200,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 4),
                                                child: Text(
                                                  'Lớp 6.2',
                                                  style: AppTextStyles.normal14(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.gray700,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '(23)',
                                                style: AppTextStyles.normal14(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.gray700,
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: RoundedButton(
                            onTap: () {},
                            borderRadius: 70,
                            buttonColor: AppColors.primaryRedColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            icon: Assets.icons.editProfile
                                .svg(color: AppColors.white, height: 24),
                            child: Text(
                              'Nhập điểm',
                              style: AppTextStyles.semiBold16(
                                  color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ScoreAppbar extends StatelessWidget {
  const ScoreAppbar({
    super.key,
    required this.scoreData,
    required this.selectedOption,
    required this.onUpdateYear,
  });

  final ScoreModel scoreData;
  final String selectedOption;
  final void Function(String newYear) onUpdateYear;

  @override
  Widget build(BuildContext context) {
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
          margin: const EdgeInsets.only(top: 28, right: 16),
          width: 130,
          child: DropdownButtonComponent(
            selectedOption: selectedOption,
            onUpdateOption: onUpdateYear,
            hint: 'Chọn năm học',
            optionList: scoreData.listYear,
            isSelectYear: true,
          ),
        ),
      ],
    );
  }
}
