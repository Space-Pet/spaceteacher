import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/screens/score/views/class_score/widgets/class_score_tab.dart';

class ClassScoreScreen extends StatelessWidget {
  const ClassScoreScreen({super.key});

  static const String routeName = '/class-score';

  @override
  Widget build(BuildContext context) {
    return const ClassScoreView();
  }
}

class ClassScoreView extends StatefulWidget {
  const ClassScoreView({super.key});

  @override
  State<ClassScoreView> createState() => ClassScoreViewState();
}

class ClassScoreViewState extends State<ClassScoreView> {
  var _selectedOption = 'Học kỳ 1';

  final List<String> tabs = ['Giũa kỳ', 'Cuối kỳ', 'Cả năm'];

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ScreenAppBar(
            title: 'Lớp 6.2',
            canGoback: true,
            onBack: () {
              Navigator.of(context).pop();
            },
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
                      optionList: const ['Học kỳ 1', 'Học kỳ 2'],
                      hint: 'Chọn học kỳ',
                      selectedOption: _selectedOption,
                      onUpdateOption: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 20, 14, 16),
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
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.67),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: TabBar(
                                  labelColor: AppColors.red,
                                  unselectedLabelColor: AppColors.gray400,
                                  dividerColor: Colors.transparent,
                                  labelStyle: AppTextStyles.semiBold14(),
                                  unselectedLabelStyle:
                                      AppTextStyles.normal14(),
                                  indicator: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        spreadRadius: 0.5,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  indicatorPadding: const EdgeInsets.symmetric(
                                      horizontal: -15),
                                  tabs: _buildTabs(),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: TabBarView(
                                children: [
                                  ClassScoreTab(),
                                  ClassScoreTab(),
                                  ClassScoreTab(),
                                ],
                              ),
                            )
                          ],
                        ),
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
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Align(
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }).toList();
  }
}
