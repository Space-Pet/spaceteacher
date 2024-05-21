import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/profile_iportal2/bloc/profile_bloc.dart';
import 'package:teacher/screens/profile_iportal2/widget/profile_app_bar.dart';
import 'package:teacher/screens/profile_iportal2/widget/tab_bar_parent.dart';
import 'package:repository/repository.dart';

import 'widget/tab_bar_student.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        userRepository: context.read<UserRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          final userData = profileState.studentData;
          final parentData = profileState.parentData;

          return BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              final isParent = state.user.type == ProfileType.parent.value;

              return BackGroundContainer(
                child: Column(
                  children: [
                    ProfileAppBar(
                      user: userData,
                      isParent: isParent,
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
                            Image(
                              image: state.user.brandLogo(),
                              height: 100,
                            ),
                            isParent
                                ? TabBarParent(parentData: parentData)
                                : TabBarStudent(studentData: userData)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
