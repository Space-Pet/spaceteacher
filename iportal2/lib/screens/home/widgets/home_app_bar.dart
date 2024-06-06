import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/message/message_screen.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:iportal2/screens/profile/profile_screen.dart';
import 'package:iportal2/screens/profile/widget/profile_bottom_sheet.dart';
import 'package:repository/repository.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileBloc = ProfileBloc(
      userRepository: context.read<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );

    return BlocProvider.value(
      value: profileBloc,
      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          final activeChildData = state.activeChild;
          final listChildren = state.user.children;
          final urlImage = activeChildData.url_image.mobile;

          final isStudent = state.user.isStudent();

          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final urlAva =
                  isStudent ? state.studentData.avatar.mobile : urlImage;

              return Padding(
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
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(urlAva)),
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  border: Border.all(
                                      color: AppColors.white, width: 2)),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activeChildData.full_name,
                                  style: AppTextStyles.semiBold12(
                                    color: AppColors.white,
                                  ),
                                ),
                                Text(
                                  'Lớp ${activeChildData.class_name}',
                                  style: AppTextStyles.normal12(
                                    color: AppColors.white,
                                  ),
                                )
                              ],
                            ),
                            if (!isStudent && listChildren.length > 1)
                              IconButton(
                                padding: const EdgeInsets.only(left: 16),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) =>
                                        const SelectChildrenBottomSheet(),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(const MessageScreen());
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
              );
            },
          );
        },
      ),
    );
  }
}
