import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/survey/bloc/survey_bloc.dart';
import 'package:teacher/screens/survey/widget/survey_detail.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  static const routeName = '/survey_list';

  @override
  Widget build(BuildContext context) {
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final currentUserBloc = context.read<CurrentUserBloc>();
    final surveyBloc = SurveyBloc(
      appFetchApiRepository: appFetchApiRepository,
      currentUserBloc: currentUserBloc,
    );
    return BlocProvider.value(
      value: surveyBloc,
      child: const SurveyView(),
    );
  }
}

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
      final surveyList = state.surveyList;
      final isLoading = state.surveyStatus == SurveyStatus.loadingSurvey;
      final isEmpty = surveyList.isEmpty && !isLoading;

      return Scaffold(
        body: BackGroundContainer(
            child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: 'Khảo sát',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
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
                    isLoading: isLoading,
                    child: isEmpty
                        ? const EmptyScreen(text: 'Chưa có khảo sát nào')
                        : SurveyList(surveyList: surveyList),
                  ),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}

class SurveyList extends StatelessWidget {
  const SurveyList({super.key, required this.surveyList});

  final List<Survey> surveyList;

  @override
  Widget build(BuildContext context) {
    final surveyListW = List.generate(surveyList.length, (index) {
      final survey = surveyList[index];
      final isCompleted = survey.status == 1;
      return InkWell(
        onTap: () {
          mainNavKey.currentContext?.push(
            SurveyDetailScreen(
              khaoSatId: survey.khaoSatId,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                survey.name,
                style: AppTextStyles.semiBold16(color: AppColors.gray700),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (survey.hocKy != null && survey.hocKy != 0)
                        Text(
                          'Học kỳ: ${survey.hocKy}',
                          style:
                              AppTextStyles.normal12(color: AppColors.gray800),
                        ),
                      Text(
                        survey.learnYear,
                        style: AppTextStyles.normal12(color: AppColors.gray800),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    decoration: BoxDecoration(
                      color:
                          isCompleted ? AppColors.green100 : AppColors.blue100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isCompleted
                          ? 'Đã hoàn thành khảo sát'
                          : 'Tham gia khảo sát',
                      style: AppTextStyles.semiBold12(
                          color: isCompleted
                              ? AppColors.green600
                              : AppColors.blue600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Danh sách khảo sát',
            style: AppTextStyles.semiBold20(color: AppColors.black24),
          ),
          const SizedBox(height: 12),
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: surveyListW),
          )),
        ],
      ),
    );
  }
}
