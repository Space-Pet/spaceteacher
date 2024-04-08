import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/student_score/widget/app_bar_score.dart';
import 'package:iportal2/screens/student_score_screen_pre/widget/Component/badge_pre_school.dart';
import 'package:iportal2/screens/student_score_screen_pre/widget/Component/feedback_group.dart';
import 'package:iportal2/screens/student_score_screen_pre/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_decoration.dart';
import 'package:iportal2/app_config/router_configuration.dart';

class StudentScoreScreenPre extends StatefulWidget {
  const StudentScoreScreenPre({super.key});
  @override
  State<StudentScoreScreenPre> createState() => StudentScoreScreenPreState();
}

class StudentScoreScreenPreState extends State<StudentScoreScreenPre> {
  String selectedScoreType = "Điểm MOET";

  void handleSelectedOptionChanged(String newOption) async {
    setState(() {
      selectedScoreType = newOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Nhận xét',
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
                              SelectFeedBackType(
                                onSelectedOptionChanged:
                                    handleSelectedOptionChanged,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SvgPicture.asset(
                          'assets/icons/nice-reward-badge.svg',
                          height: 192,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const BadgePreSchool(),
                        const SizedBox(
                          height: 16,
                        ),
                        const FeedbackGroup()
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
