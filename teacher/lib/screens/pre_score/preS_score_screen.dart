// ignore_for_file: file_names

import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/pre_score/add_pre_score.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/screens/pre_score/view_pre_score.dart';

class PreScoreScreen extends StatelessWidget {
  const PreScoreScreen({super.key});

  static const routeName = '/pre-score';

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);

    preScoreBloc.add(GetTeacherDetail());
    return BlocProvider.value(
      value: preScoreBloc,
      child: BlocListener<PreScoreBloc, PreScoreState>(
        listener: (context, state) {
          if (state.preScoreStatus == PreScoreStatus.successGetTeacherDetail) {
            preScoreBloc.add(GetListStudents());
          }
        },
        child: const StudentScoreViewPre(),
      ),
    );
  }
}

class StudentScoreViewPre extends StatefulWidget {
  const StudentScoreViewPre({super.key});
  @override
  State<StudentScoreViewPre> createState() => StudentScoreViewPreState();
}

class StudentScoreViewPreState extends State<StudentScoreViewPre> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final listStudent = state.listStudent;
      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: listStudent.length,
                          itemBuilder: (context, index) {
                            final item = listStudent[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  context.push(ViewPreScoreScreen(
                                    phoneBookStudent: item,
                                  ));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(item.urlImage.mobile),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.fullName,
                                            style: AppTextStyles.normal14(
                                              color: AppColors.brand600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            item.pupilId.toString(),
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray400,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.push(
                                AddPreScoreScreen(
                                  phoneBookStudent: listStudent,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: const Color(0xFF9C292E),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                'Nhập nhận xét',
                                style: AppTextStyles.semiBold14(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(6),
                                backgroundColor: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                'Nhập báo cáo',
                                style: AppTextStyles.semiBold14(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
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
    });
  }
}
