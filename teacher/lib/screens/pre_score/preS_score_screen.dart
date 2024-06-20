import 'package:core/core.dart';
import 'package:core/data/models/phone_book_student.dart';
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
import 'package:teacher/screens/pre_score/report_score/list_student_screen.dart';
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
    preScoreBloc.add(GetListAllForm());
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
      final listAllForm = state.listAllForm;
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
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: AppColors.brand600,
                        unselectedLabelColor: AppColors.gray400,
                        tabs: [
                          Tab(text: 'Nhận xét'),
                          Tab(text: 'Báo cáo'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ViewComment(listStudent: listStudent),
                            ViewReport(listAllForm: listAllForm),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ViewReport extends StatelessWidget {
  const ViewReport({super.key, required this.listAllForm});

  final List<ListAllForm> listAllForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: listAllForm.length,
              itemBuilder: (context, index) {
                final item = listAllForm[index];
                return GestureDetector(
                  onTap: () {
                    context.push(ListStudentScreen(
                      listAllForm: item,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.brand600, width: 1),
                      ),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 50,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: AppTextStyles.normal14(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Container(
                                    color: AppColors.brand600,
                                    width: 4,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tên biểu mẫu',
                                        style: AppTextStyles.normal14(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        item.title,
                                        overflow: TextOverflow
                                            .ellipsis, // Truncate text if too long
                                        maxLines: 5, // Limit text to one line
                                        style: AppTextStyles.normal14(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ViewComment extends StatelessWidget {
  const ViewComment({
    super.key,
    required this.listStudent,
  });

  final List<PhoneBookStudent> listStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          backgroundImage: NetworkImage(item.urlImage.mobile),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    style: AppTextStyles.semiBold14(color: Colors.white),
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
    );
  }
}
