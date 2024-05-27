import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/survey_iportal2/bloc/survey_bloc.dart';
import 'package:teacher/screens/survey_iportal2/widget/tab_bar_survey.dart';
import 'package:repository/repository.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final surveyBloc = SurveyBloc(appFetchApiRepository: appFetchApiRepository);
    surveyBloc.add(GetSurvey());
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
      final isLoading = state.surveyStatus == SurveyStatus.loadingSurvey;
      final surveyData = state.surveyData;

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
                    child: SurveyPageView(surveyData: surveyData)),
              ))
            ],
          ),
        )),
      );
    });
  }
}
