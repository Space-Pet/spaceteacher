import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';

class FormDetailScreen extends StatelessWidget {
  const FormDetailScreen({super.key, required this.listStudentFormReport});
  final ListStudentFormReport listStudentFormReport;

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    preScoreBloc.add(
      GetFormDetail(
        id: int.parse(listStudentFormReport.evaluationFormId),
        pupilId: listStudentFormReport.id,
      ),
    );
    return BlocProvider.value(
      value: preScoreBloc,
      child: const FormDetailView(),
    );
  }
}

class FormDetailView extends StatelessWidget {
  const FormDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(
      builder: (context, state) {
        final formDetail = state.formDetail;
        return BackGroundContainer(
          child: Column(
            children: [
              const ScreensAppBar(
                'Báo cáo học tập',
                canGoBack: true,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                        PreScoreStatus.loadingGetFormDetail,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.features.report,
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                'Thang đánh giá',
                                style: AppTextStyles.normal16(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brand600,
                                ),
                              ),
                            )
                          ],
                        ),
                        EvaluatioTarget(formDetail: formDetail),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.features.report,
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                'Mục tiêu học tập và tiêu chí đánh giá',
                                style: AppTextStyles.normal16(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brand600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: formDetail.data.items.length,
                            itemBuilder: (context, index) {
                              final item = formDetail.data.items[index];
                              return Container(
                                child: GFAccordion(
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  titleChild: Text(
                                    item.title,
                                    style: AppTextStyles.normal14(
                                        color: AppColors.brand200),
                                  ),
                                  collapsedIcon: Icon(Icons.keyboard_arrow_up),
                                  expandedIcon: Icon(Icons.keyboard_arrow_down),
                                  contentChild: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        item.listCriterial.map((itemData) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                color: AppColors.brand600,
                                                width: 4,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  itemData.criterialTitle,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
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
      },
    );
  }
}

class EvaluatioTarget extends StatelessWidget {
  const EvaluatioTarget({
    super.key,
    required this.formDetail,
  });

  final FormDetail formDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gray100,
          width: 1,
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: formDetail.listMarks.length,
        itemBuilder: (context, index) {
          final item = formDetail.listMarks[index];
          final color;
          if (index % 3 == 0) {
            color = AppColors.red;
          } else if (index % 3 == 1) {
            color = AppColors.brand600;
          } else {
            color = AppColors.green;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: color,
                  ),
                  child: Center(
                    child: Text(
                      item.value.toString(),
                      style: AppTextStyles.normal10(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.normal14(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: item.title,
                          style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' ${item.description}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
