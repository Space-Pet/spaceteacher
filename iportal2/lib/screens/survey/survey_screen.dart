import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:core/resources/resources.dart';
import 'package:iportal2/screens/survey/bloc/survey_bloc.dart';
import 'package:iportal2/screens/survey/widget/tab_bar_survey.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

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

      return BackGroundContainer(
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
                  skeleton: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: index == 4
                                  ? BorderSide.none
                                  : const BorderSide(color: AppColors.gray300),
                            ),
                          ),
                          child: SkeletonItem(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SkeletonParagraph(
                                      style: SkeletonParagraphStyle(
                                          lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 10,
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                        ),
                      )),
                  isLoading: isLoading,
                  child: SurveyPageView(surveyData: surveyData ?? [])),
            ))
          ],
        ),
      ));
    });
  }
}
