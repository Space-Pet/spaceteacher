import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/tab_bar/tab_bar_pre_score.dart';

class ViewPreScoreScreen extends StatelessWidget {
  const ViewPreScoreScreen({
    super.key,
    required this.phoneBookStudent,
  });
  final PhoneBookStudent phoneBookStudent;

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );

    return BlocProvider.value(
      value: preScoreBloc,
      child: ViewPreScore(
        phoneBookStudent: phoneBookStudent,
      ),
    );
  }
}

class ViewPreScore extends StatelessWidget {
  const ViewPreScore({
    super.key,
    required this.phoneBookStudent,
  });
  final PhoneBookStudent phoneBookStudent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(
      builder: (context, state) {
        return BackGroundContainer(
          child: Column(
            children: [
              const ScreensAppBar(
                'Nhận xét',
                canGoBack: true,
              ),
              Expanded(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 18,
                              child: SvgPicture.asset(
                                phoneBookStudent.urlImage.mobile,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  phoneBookStudent.fullName,
                                  style: AppTextStyles.normal14(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brand600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      phoneBookStudent.schoolName,
                                      style: AppTextStyles.normal14(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.gray400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.gray400,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      phoneBookStudent.className,
                                      style: AppTextStyles.normal14(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.gray400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TabBarPreScore(
                        phoneBookStudent: phoneBookStudent,
                      ),
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
