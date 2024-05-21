import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_decoration.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/dropdown/dropdown_subject.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/screens/exercise_notice/bloc/exercise_bloc.dart';
import 'package:iportal2/screens/exercise_notice/widgets/excersise_note/exercise_note_list.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    DateFormat formatDateDrill = DateFormat("dd-MM-yyyy", 'vi_VN');

    return BlocProvider(
      create: (context) => ExerciseBloc(
        todayString: formatDateDrill.format(DateTime.now()),
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: const ExerciseScreenView(),
    );
  }
}

class ExerciseScreenView extends StatelessWidget {
  const ExerciseScreenView({
    super.key,
  });
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Sổ báo bài',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              final exerciseBloc = context.read<ExerciseBloc>();

              final isLoading = state.status == ExerciseStatus.loading;
              final exerciseList = state.tempData;

              final listSubject = state.subjectList;

              final isEmpty = exerciseList.isEmpty && !isLoading;

              return Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SelectDate(
                        onDatePicked: (date) {
                          exerciseBloc
                              .add(ExerciseSelectDate(datePicked: date));
                        },
                      ),
                      const SizedBox(height: 16),
                      if (!isEmpty)
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/exercise.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Chọn môn',
                                  style: AppTextStyles.normal14(),
                                )
                              ],
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: DropdownSelectSubject(
                                hint: 'Tất cả các môn',
                                optionList: [
                                  'Tất cả các môn',
                                  ...listSubject,
                                ],
                                selectedOption: state.selectedSubject,
                                onUpdateOption: (value) {
                                  exerciseBloc.add(
                                    ExerciseSelectSubject(
                                        selectedSubject: value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: CustomRefresh(
                          onRefresh: () async {
                            exerciseBloc.add(ExerciseFetchData());
                          },
                          child: Stack(
                            children: [
                              ListView(),
                              AppSkeleton(
                                isLoading: isLoading,
                                skeleton: const ExerciseSkeleton(),
                                child: isEmpty
                                    ? const Center(
                                        child: EmptyScreen(
                                            text: 'Sổ báo bài trống'),
                                      )
                                    : ExerciseItemList(
                                        exercise: exerciseList,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ExerciseSkeleton extends StatelessWidget {
  const ExerciseSkeleton({
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
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            decoration: BoxDecoration(
              borderRadius: AppRadius.rounded14,
              border: Border.all(color: AppColors.gray300),
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
