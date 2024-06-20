import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/report_score/form_detail_screen.dart';

class ListStudentScreen extends StatelessWidget {
  const ListStudentScreen({
    super.key,
    required this.listAllForm,
  });
  final ListAllForm listAllForm;

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    preScoreBloc.add(GetTeacherDetail());

    return BlocProvider.value(
      value: preScoreBloc,
      child: BlocListener<PreScoreBloc, PreScoreState>(
        listener: (context, state) {
          if (state.preScoreStatus == PreScoreStatus.successGetTeacherDetail) {
            preScoreBloc.add(GetListStudentReport(
              id: listAllForm.id,
              classId: state.userData.lopChuNhiem.id,
            ));
          }
        },
        child: ListStudentView(),
      ),
    );
  }
}

class ListStudentView extends StatelessWidget {
  const ListStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(
      builder: (context, state) {
        final listStudentReport = state.listStudentFormReport;
        return BackGroundContainer(
          child: Column(
            children: [
              const ScreensAppBar(
                'Danh sách học sinh theo biểu mẫu',
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
                  child: AppSkeleton(
                    isLoading: state.preScoreStatus ==
                        PreScoreStatus.loadingGetListStudentReport,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: listStudentReport.length,
                        itemBuilder: (context, index) {
                          final item = listStudentReport[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              left: 8,
                              right: 8,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.push(FormDetailScreen(
                                  listStudentFormReport: item,
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.brand600,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Tên học sinh: ',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.brand600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            item.fullName,
                                            style: AppTextStyles.normal14(
                                              color: AppColors.brand600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item.id.toString(),
                                        style: AppTextStyles.normal14(
                                          color: AppColors.gray400,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
