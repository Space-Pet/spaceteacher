import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/profile_teacher/widget/profile_app_bar.dart';

import 'widget/teacher_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.teacherInfo,
  });

  final TeacherDetail teacherInfo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final brandLogo = state.user.brandLogo();

        return BackGroundContainer(
          child: Column(
            children: [
              ProfileAppBar(
                user: teacherInfo,
                onBack: () {
                  context.pop();
                },
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 32),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Image(image: brandLogo, height: 100),
                      ),
                      TeacherGeneralInfo(teacher: teacherInfo)
                    ],
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
