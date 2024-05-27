import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:iportal2/screens/register_notebook/register_lesson.dart';
import 'package:repository/repository.dart';

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
              lessonDataItem: lesson,
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
