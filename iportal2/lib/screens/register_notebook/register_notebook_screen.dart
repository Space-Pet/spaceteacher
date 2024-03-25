import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/attendance/widget/app_bar_attendence.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:iportal2/screens/register_notebook/tab_instruction.dart';
import 'package:iportal2/screens/week_schedule/week_schedule_screen.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_decoration.dart';

class RegisterNoteBoookScreen extends StatefulWidget {
  const RegisterNoteBoookScreen({super.key});

  static const routeName = '/register_notebook';

  @override
  State<RegisterNoteBoookScreen> createState() =>
      _RegisterNoteBoookScreenState();
}

class _RegisterNoteBoookScreenState extends State<RegisterNoteBoookScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Sổ đầu bài',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [
                  const AppBarAttendance(),
                  const SelectDate(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RegisterLessons(
                            title: 'Buổi sáng',
                            lessons: lessons,
                          ),
                          const SizedBox(height: 16),
                          RegisterLessons(
                            title: 'Buổi chiều',
                            lessons: lessons,
                          ),
                        ],
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
  }
}
