import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/home/bloc/home_bloc.dart';
import 'package:teacher/screens/message/message_screen.dart';
import 'package:teacher/screens/profile_teacher/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final userData = state.userData;
        final urlImage = userData.info.urlImage.mobile;
        final isLoading = state.profileStatus == HomeStatus.init;

        return AppSkeleton(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: InkWell(
              onTap: () {
                context.push(ProfileScreen(teacherInfo: userData));
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
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/default-user.png',
                              image: urlImage,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/default-user.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.info.fullName,
                              style: AppTextStyles.semiBold12(
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              userData.info.mainSubject,
                              style: AppTextStyles.normal12(
                                color: AppColors.white,
                              ),
                            )
                          ],
                        )
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
          ),
        );
      },
    );
  }
}
