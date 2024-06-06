import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:iportal2/screens/profile/widget/profile_app_bar.dart';
import 'package:iportal2/screens/profile/widget/tab_bar_parent.dart';

import 'widget/tab_bar_student.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.profileBloc,
  });

  final ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          final studentData = profileState.studentData;
          final parentData = profileState.parentData;

          return BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              final isParent = !state.user.isStudent();

              return BackGroundContainer(
                child: Column(
                  children: [
                    ProfileAppBar(
                      studentData: studentData,
                      parentData: parentData,
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
                              image: state.activeChild.brandLogo(),
                              height: 100,
                            ),
                            isParent
                                ? TabBarParent(parentData: parentData)
                                : TabBarStudent(studentData: studentData)
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
