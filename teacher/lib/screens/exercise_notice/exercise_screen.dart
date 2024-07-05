import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar_filter_class.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/exercise_notice/bloc/exercise_bloc.dart';
import 'package:teacher/screens/exercise_notice/exercise_lesson.dart';
import 'package:teacher/screens/register_notebook/register_notebook_screen.dart';
import 'package:teacher/screens/schedule/bloc/schedule_bloc.dart';
import 'package:teacher/screens/schedule/select_week.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseBloc(
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
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          final exerciseBloc = context.read<ExerciseBloc>();
          final lessonData = state.lessonData;

          final isLoading = state.status == ExerciseStatus.loading;
          final isEmpty = lessonData.isEmpty && !isLoading;

          final listTab = List.generate(lessonData.length, (index) {
            String originalDate = lessonData[index].ngay.day;
            DateTime dateTime = DateFormat('dd-MM-yyyy').parse(originalDate);

            return TabDayOfWeek(
              date: DateFormat('dd-MM').format(dateTime).toString(),
              dayOfW: 'Thứ ${lessonData[index].ngay.date}',
            );
          });

          final lessonListW = List.generate(lessonData.length, (index) {
            return ExerciseLesson(
              lesson: lessonData[index].dataList,
              noBoder: index == lessonData.length - 1,
            );
          });

          final initialIndex = lessonData.indexWhere(
              (element) => element.ngay.date - 1 == DateTime.now().weekday);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBarFilterClass(
                  title: 'Sổ báo bài',
                  classSelect: state.classType.value,
                  onBack: () {
                    context.pop();
                  },
                  onChangeClassType: (value) {
                    exerciseBloc
                        .add(ExerciseChangeClassType(classTypeName: value));
                  }),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      if (isEmpty)
                        SelectDate(
                          onDatePicked: (date) {
                            exerciseBloc
                                .add(ExerciseSelectDate(datePicked: date));
                          },
                        ),
                      if (!isEmpty)
                        WeekSelect(
                          date: exerciseBloc.state.datePicked,
                          onDatePicked: (date) {
                            exerciseBloc
                                .add(ExerciseSelectDate(datePicked: date));
                          },
                        ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: isEmpty
                              ? const Center(
                                  child: EmptyScreen(
                                    text: 'Không có dữ liệu',
                                  ),
                                )
                              : DefaultTabController(
                                  length: lessonData.length,
                                  initialIndex: initialIndex == -1 ||
                                          initialIndex > lessonData.length - 1
                                      ? 0
                                      : initialIndex,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        padding: const EdgeInsets.all(0),
                                        labelPadding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        labelColor: AppColors.brand600,
                                        tabAlignment: TabAlignment.fill,
                                        unselectedLabelColor: AppColors.gray500,
                                        dividerColor: AppColors.gray200,
                                        labelStyle: AppTextStyles.semiBold14(
                                            color: AppColors.brand600),
                                        unselectedLabelStyle:
                                            AppTextStyles.normal14(
                                                color: AppColors.gray500),
                                        indicator: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                          ),
                                          color: AppColors.gray100,
                                        ),
                                        tabs: listTab,
                                      ),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              AppRadius.roundedBottom12,
                                          child:
                                              TabBarView(children: lessonListW),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
