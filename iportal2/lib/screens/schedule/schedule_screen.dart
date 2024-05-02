import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/dialog/dialog_scale_animated.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/schedule/bloc/schedule_bloc.dart';
import 'package:iportal2/screens/schedule/schedule_tabs.dart';
import 'package:iportal2/screens/schedule/select_week.dart';
import 'package:iportal2/utils/validation_functions.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  static const routeName = '/schedule';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => ScheduleBloc(
        context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          final bloc = context.read<ScheduleBloc>();
          final isLoading = state.status == ScheduleStatus.loading;
          final scheduleData = state.scheduleData.tkbData;

          onViewExercise(DateTime date, int tietNum) {
            bloc.add(ScheduleFetchExercise(datePicked: date));

            showDialog(
              context: context,
              builder: (_) => BlocBuilder<ScheduleBloc, ScheduleState>(
                bloc: bloc,
                builder: (context, state) {
                  final exerciseData = state.exerciseDataList.exerciseDataList;
                  final isEmptyExercise = exerciseData.isEmpty;

                  final exercise = isEmptyExercise
                      ? null
                      : exerciseData.firstWhere(
                          (element) => int.parse(element.tietNum) == tietNum,
                          orElse: () => ExerciseItem.empty());

                  final fileName = getFileName(exercise?.fileBaoBai ?? '');

                  return DialogScaleAnimated(
                    title: 'Báo bài hôm nay',
                    content: fileName,
                    isLink: true,
                    link:
                        'https://${exercise?.fileBaoBaiDomain}/${exercise?.fileBaoBai}',
                  );
                },
              ),
            );
          }

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Thời khóa biểu',
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop28,
                    ),
                    child: Column(
                      children: [
                        WeekSelect(
                          date: state.datePicked,
                          onDatePicked: (date) {
                            bloc.add(ScheduleSelectDate(datePicked: date));
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: AppRadius.rounded10,
                            child: AppSkeleton(
                              isLoading: isLoading,
                              skeleton: const ScheduleSkeleton(),
                              child: ScheduleTabs(
                                lessons: scheduleData,
                                datePicked: state.datePicked,
                                onViewExercise: onViewExercise,
                              ),
                            ),
                          ),
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

  @override
  bool get wantKeepAlive => true;
}

class ScheduleSkeleton extends StatelessWidget {
  const ScheduleSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        ));
  }
}
