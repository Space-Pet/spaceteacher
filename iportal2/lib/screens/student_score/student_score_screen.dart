import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/student_score/widget/app_bar_score.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_score/select_option_button_score_type.dart';
import 'package:iportal2/screens/student_score/widget/select_button/select_button_term/select_option_button_term.dart';
import 'package:iportal2/screens/student_score/widget/tab_bar_score.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_decoration.dart';

class StudentScoreScreen extends StatefulWidget {
  const StudentScoreScreen({super.key});
  @override
  State<StudentScoreScreen> createState() => StudentScoreScreenState();
}

class StudentScoreScreenState extends State<StudentScoreScreen> {
  String selectedScoreType = "Điểm MOET";
  List<String> renderedTabs = ['Giữa kỳ', 'Cuối kỳ', 'Cả năm'];

  void handleSelectedOptionChanged(String newOption) {
    setState(() {
      selectedScoreType = newOption;
    });
  }

  void handleSelectedTermChange(String newOption) async {
    if (newOption == "Học kỳ 1") {
      setState(() {
        renderedTabs = ['Giữa kỳ', 'Cuối kỳ'];
      });
    } else {
      setState(() {
        renderedTabs = ['Giữa kỳ', 'Cuối kỳ', 'Cả năm'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double calculatedHeight = screenHeight - 72 - 184 - 72 - 43;
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Xem điểm',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop28,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              const AppBarScore(),
                              SelectScoreType(
                                onSelectedOptionChanged:
                                    handleSelectedOptionChanged,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SelectTerm(
                                onSelectedOptionChanged:
                                    handleSelectedTermChange,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: calculatedHeight,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.401, 1.0],
                                colors: [
                                  Color(0xFFDFEEFF), // #DFEEFF
                                  Color(0xFFFFFFFF), // #FFF
                                  Color(0xFFFFFFFF), // #FFF
                                ],
                              ),
                            ),
                            child: TabBarScore(
                                renderedTabs: renderedTabs,
                                selectedScoreType: selectedScoreType)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
