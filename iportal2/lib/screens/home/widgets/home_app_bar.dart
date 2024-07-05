import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/message/message_screen.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:iportal2/screens/profile/profile_screen.dart';
import 'package:iportal2/screens/profile/widget/profile_bottom_sheet.dart';
import 'package:repository/repository.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = ProfileBloc(
      userRepository: context.read<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          final activeChildData = state.activeChild;
          final listChildren = state.user.children;

          final isStudent = state.user.isStudent();

          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final studentData = state.studentData;
              final urlAva = studentData.avatar.mobile;
              final isLoading = state.profileStatus == ProfileStatus.init;

              return AppSkeleton(
                isLoading: isLoading,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: InkWell(
                    onTap: () {
                      context.push(ProfileScreen(
                        profileBloc: profileBloc,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              CircleAvaImage(urlAva: urlAva),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        studentData.pupil.name,
                                        style: AppTextStyles.semiBold14(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (!isStudent && listChildren.length > 1)
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) =>
                                                  const SelectChildrenBottomSheet(),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColors.white,
                                            size: 28,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    'Lớp ${studentData.classInfo.name}',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            mainNavKey.currentContext!.pushNamed(
                              routeName: MessageScreen.routeName,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 0.205),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/noti.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
