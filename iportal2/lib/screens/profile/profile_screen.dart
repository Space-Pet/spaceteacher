import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/dialog/show_dialog.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:iportal2/screens/profile/widget/profile_app_bar.dart';
import 'package:iportal2/screens/profile/widget/tab_bar_parent.dart';
import 'package:repository/repository.dart';

import 'widget/tab_bar_student.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final profileBloc = ProfileBloc(
        userRepository: userRepository,
        currentUserBloc: context.read<CurrentUserBloc>());
    profileBloc.add(const GetProfileUser());
    return BlocProvider.value(
      value: profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) {
            return previous.profileStatus != current.profileStatus;
          },
          listener: (context, state) {
            if (state.profileStatus == ProfileStatus.initUpdate) {
              LoadingDialog.show(context);
            } else if (state.profileStatus == ProfileStatus.fail) {
              LoadingDialog.hide(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShowDialog(
                      title: 'Lỗi',
                      textConten: state.message ?? '',
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFECFDF3),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFD1FADF),
                          child: Icon(
                            Icons.error,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state.profileStatus == ProfileStatus.error) {
              LoadingDialog.hide(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShowDialog(
                      title: 'Lỗi',
                      textConten: state.message ?? '',
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFECFDF3),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFD1FADF),
                          child: Icon(
                            Icons.error,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state.profileStatus == ProfileStatus.successUpdate) {
              LoadingDialog.hide(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ProfileScreen();
                },
              ));
            }
          },
          child: const ProfileView()),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  final int role = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, stateProfile) {
      return BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (stateProfile.profileStatus == ProfileStatus.init) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final profile = stateProfile.studentData;
            final local = stateProfile.user;
            return BackGroundContainer(
              child: Column(
                children: [
                  ProfileAppBar(
                    user: state.user,
                    onBack: () {
                      context.pop();
                    },
                    role: role,
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image(
                              image: state.user.brandLogo(),
                              height: 100,
                            ),
                          ),
                          if (role == 0)
                            TabBarStudent(
                              studentData: profile,
                            ),
                          if (role == 1) const TabBarParent()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );
    });
  }
}
