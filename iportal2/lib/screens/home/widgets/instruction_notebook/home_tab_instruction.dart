import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/screens/exercise_notice/widgets/excersise_note/exercise_note_list.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:skeletons/skeletons.dart';

class HomeTabsInstruction extends StatelessWidget {
  const HomeTabsInstruction({
    super.key,
    required this.exercisesDueDate,
    required this.exercisesInDay,
  });

  final List<ExerciseItem> exercisesDueDate;
  final List<ExerciseItem> exercisesInDay;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = context.read<HomeBloc>();
        final isLoading = state.statusExercise == HomeStatus.loading;
        final isEmptyInDay = exercisesInDay.isEmpty && !isLoading;
        final dateSelected = state.datePicked;
        DateFormat formatDate = DateFormat("yyyy-MM-dd");

        final listExerciseDueDate = exercisesDueDate
            .where((element) =>
                element.hanNopBaoBai == formatDate.format(dateSelected))
            .toList();

        final isEmptyDueDate = listExerciseDueDate.isEmpty && !isLoading;

        return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                SelectDate(
                  datePicked: state.datePicked,
                  onDatePicked: (date) {
                    bloc.add(HomeExerciseSelectDate(
                      datePicked: date,
                    ));
                  },
                ),
                const SizedBox(height: 12),
                TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    labelColor: AppColors.brand600,
                    unselectedLabelColor: AppColors.gray500,
                    dividerColor: AppColors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle:
                        AppTextStyles.semiBold14(color: AppColors.brand600),
                    unselectedLabelStyle:
                        AppTextStyles.normal14(color: AppColors.gray500),
                    indicator: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      color: AppColors.gray100,
                    ),
                    tabs: const [
                      Tab(
                        child: Align(
                          child: Text("Báo bài đến hạn"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          child: Text("Báo bài hôm nay"),
                        ),
                      ),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    isLoading
                        ? const InstructrionSkeleton()
                        : isEmptyDueDate
                            ? const Center(
                                child: EmptyScreen(text: 'Sổ báo bài trống'))
                            : Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: AppColors.gray100,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: ExerciseItemList(
                                    isHomeScreenView: true,
                                    exercise: exercisesDueDate,
                                  ),
                                ),
                              ),
                    isLoading
                        ? const InstructrionSkeleton()
                        : isEmptyInDay
                            ? const Center(
                                child: EmptyScreen(text: 'Sổ báo bài trống'))
                            : Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: AppColors.gray100,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: ExerciseItemList(
                                    exercise: exercisesInDay,
                                    isHomeScreenView: true,
                                    isTodayView: true,
                                  ),
                                ),
                              ),
                  ]),
                ),
              ],
            ));
      },
    );
  }
}

class InstructrionSkeleton extends StatelessWidget {
  const InstructrionSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 6),
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray300),
              borderRadius: AppRadius.rounded20,
              color: AppColors.white,
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
                          maxLength: MediaQuery.of(context).size.width / 3,
                        )),
                      ),
                    )
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
