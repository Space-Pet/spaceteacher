import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/dialog/dialog_scale_animated.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/home_tab_instruction.dart';
import 'package:iportal2/screens/schedule/bloc/schedule_bloc.dart';
import 'package:iportal2/utils/validation_functions.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const routeName = '/schedule';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(
        context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          final bloc = context.read<ScheduleBloc>();
          final isLoading = state.status == ScheduleStatus.loading;
          final scheduleData = state.scheduleData;
          final listSchedule = state.scheduleData.tkbData.isEmpty
              ? []
              : scheduleData.tkbData[0].dateSubject;

          final exerciseData = state.exerciseDataList.exerciseDataList;

          final scheduleListW = List.generate(listSchedule.length, (index) {
            final schedule = listSchedule[index];
            ExerciseItem? exercise;
            String? fileName;

            final exercises = exerciseData.isEmpty
                ? null
                : exerciseData.where((element) {
                    if (schedule.subjectId == null) return false;
                    return element.subjectId == schedule.subjectId;
                  }).toList();

            if ((exercises ?? []).isNotEmpty) {
              exercise = exercises?[0];
              fileName = getFileName(exercise?.fileBaoBai ?? '');
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                border: Border(
                  bottom: index == listSchedule.length - 1
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray300),
                ),
              ),
              child: Row(
                crossAxisAlignment: schedule.subjectId == null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiết ${schedule.tietNum}',
                          style:
                              AppTextStyles.normal14(color: AppColors.black24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule.room ?? '',
                          style:
                              AppTextStyles.normal14(color: AppColors.gray61),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 4,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule.subjectName ?? 'Tiết trống',
                        style:
                            AppTextStyles.semiBold14(color: AppColors.black24),
                      ),
                      const SizedBox(height: 4),
                      if (schedule.teacherName != null)
                        Text(
                          'GV: ${schedule.teacherName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.normal14(color: AppColors.gray61),
                        ),
                    ],
                  )),
                  const SizedBox(width: 4),
                  if (schedule.subjectId != null)
                    GestureDetector(
                      onTap: () {
                        if (state.exerciseDataList.exerciseDataList.isEmpty) {
                          bloc.add(ScheduleFetchExercise());
                        }
                        showDialog(
                          context: context,
                          builder: (_) => DialogScaleAnimated(
                            title: 'Báo bài đến hạn',
                            content: fileName ?? 'Không có báo bài',
                            isLink: true,
                            link:
                                'https://${exercise?.fileBaoBaiDomain}/${exercise?.fileBaoBai}',
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/icons/advice.svg'),
                    ),
                ],
              ),
            );
          });

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
                    padding: const EdgeInsets.fromLTRB(16, 26, 16, 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop28,
                    ),
                    child: Column(
                      children: [
                        SelectDate(
                          datePicked: state.datePicked,
                          onDatePicked: (date) {
                            bloc.add(ScheduleSelectDate(datePicked: date));
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: AppRadius.rounded10,
                              child: AppSkeleton(
                                isLoading: isLoading,
                                skeleton: SizedBox(
                                    height: 500,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(0),
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 12),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: index == 4
                                                ? BorderSide.none
                                                : const BorderSide(
                                                    color: AppColors.gray300),
                                          ),
                                        ),
                                        child: SkeletonItem(
                                            child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SkeletonParagraph(
                                                    style:
                                                        SkeletonParagraphStyle(
                                                            lineStyle:
                                                                SkeletonLineStyle(
                                                      randomLength: true,
                                                      height: 10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                      ),
                                    )),
                                child: Column(
                                  children: scheduleListW,
                                ),
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
}
