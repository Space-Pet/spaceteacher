import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/empty_screen.dart';
import 'package:teacher/components/select_date.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/register_lesson.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class RegisterNoteBoookScreen extends StatelessWidget {
  const RegisterNoteBoookScreen({super.key});

  static const routeName = '/register_notebook';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterNotebookBloc(
        context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<RegisterNotebookBloc, RegisterNotebookState>(
        builder: (context, state) {
          final bloc = context.read<RegisterNotebookBloc>();
          final lessonData = state.lessonData.dataList;

          final isLoading = state.status == RegisterNotebookStatus.loading;
          final isEmpty = lessonData.isEmpty && !isLoading;

          final lessonListW = List.generate(lessonData.length, (index) {
            final lesson = lessonData[index];

            return RegisterItem(
              lesson: lesson,
              noBoder: index == lessonData.length - 1,
            );
          });

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Sổ đầu bài',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        SelectDate(
                          datePicked: bloc.state.datePicked,
                          onDatePicked: (date) {
                            bloc.add(RegisterSelectDate(datePicked: date));
                          },
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: AppSkeleton(
                            isLoading: isLoading,
                            skeleton: const RegisterNotebookSkeleton(),
                            child: isEmpty
                                ? const Center(
                                    child: EmptyScreen(
                                      text: 'Không có dữ liệu',
                                    ),
                                  )
                                : Column(
                                    children: lessonListW,
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

class RegisterNotebookSkeleton extends StatelessWidget {
  const RegisterNotebookSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
