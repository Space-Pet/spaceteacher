import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/components/home_shadow_box.dart';
import 'package:teacher/screens/home/bloc/home_bloc.dart';
import 'package:teacher/screens/home/widgets/instruction_notebook/home_tab_instruction.dart';
import 'package:teacher/utils/validation_functions.dart';

class InstructionNotebook extends StatefulWidget {
  const InstructionNotebook({
    super.key,
  });

  @override
  State<InstructionNotebook> createState() => _InstructionNotebookState();
}

class _InstructionNotebookState extends State<InstructionNotebook> {
  bool isExpanded = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state.statusExercise == HomeStatus.loading;
        final exercisesDueDateToday = state.exerciseDueDateToday;

        final isDataEmpty = exercisesDueDateToday.isEmpty && !isLoading;

        final exercisesDueDate = state.exerciseDueDateDataList;
        final exercisesInDay = state.exerciseInDayDataList;

        final firstThreeExercisesDueDate =
            exercisesDueDateToday.take(3).toList();

        final lessonsW = List.generate(3, (index) {
          if (index >= firstThreeExercisesDueDate.length) {
            return SizedBox(height: 48.v);
          }

          final lesson = firstThreeExercisesDueDate[index];

          final filePath = firstThreeExercisesDueDate[index].fileBaoBai ?? '';
          final fileName = getFileName(filePath, maxLength: 12);

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: index == 2 ? 0 : 8),
              decoration: BoxDecoration(
                borderRadius: AppRadius.rounded4,
                color: AppColors.grayList,
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse(
                            'https://${lesson.fileBaoBaiDomain}/${lesson.fileBaoBai}'),
                        mode: LaunchMode.inAppBrowserView,
                      );
                    },
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lesson.subjectName,
                            style: AppTextStyles.semiBold14(
                                color: AppColors.black24),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/paperclip.svg'),
                              const SizedBox(width: 4),
                              Text(
                                fileName,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.normal12(
                                    color: AppColors.brand600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          height: isExpanded ? 580.v : 240.v,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [homeBoxShadow()],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: AppColors.red,
                        child: SvgPicture.asset(
                          'assets/icons/report.svg',
                          width: 14,
                          height: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Sổ báo bài',
                        style: AppTextStyles.semiBold14(
                          color: AppColors.blueGray800,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!isExpanded &&
                          bloc.state.datePicked == DateTime.now()) {
                        bloc.add(HomeFetchExercise(isDueDate: false));
                      }
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icons/${isExpanded ? 'chevron-up-black' : 'chevron-down'}.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: isExpanded
                    ? HomeTabsInstruction(
                        exercisesDueDate: exercisesDueDate,
                        exercisesInDay: exercisesInDay,
                      )
                    : Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.blueGray,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Thứ ${now.weekday + 1}',
                                    style: AppTextStyles.normal14(
                                        color: AppColors.gray600)),
                                const SizedBox(height: 8),
                                Text(DateFormat('dd').format(now),
                                    style: AppTextStyles.custom(
                                      color: AppColors.gray600,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.fSize,
                                      height: 32 / 24.fSize,
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                  '${DateFormat('MM').format(now)} / ${now.year}',
                                  style: AppTextStyles.normal14(
                                      color: AppColors.gray600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppSkeleton(
                              isLoading: isLoading,
                              child: isDataEmpty
                                  ? const EmptyScreen(text: 'Chưa có báo bài')
                                  : Column(
                                      children: lessonsW,
                                    ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
