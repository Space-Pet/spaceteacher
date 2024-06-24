import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_bloc.dart';
import 'package:teacher/screens/observation_schedule/widgets/card_registered_lesson.dart';

class RegisteredView extends StatelessWidget {
  const RegisteredView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      color: AppColors.white,
      child: BlocListener<ObservationBloc, ObservationState>(
        listener: (context, state) {
          if (state.registeredstatus == ObservationStatus.successDelete) {
            context.pop();
            SnackBarUtils.showFloatingSnackBar(
                context, 'Xóa tiết dự giờ thành công');
          }
        },
        child: BlocBuilder<ObservationBloc, ObservationState>(
          builder: (context, state) {
            return BlocBuilder<ObservationBloc, ObservationState>(
              builder: (context, state) {
                final registeredLessonList = state.registeredLessonList;
                final isLoading = state.registeredstatus ==
                    ObservationStatus.loadingRegisteredLesson;
                final isEmpty = registeredLessonList.isEmpty && !isLoading;

                final observationBloc = context.read<ObservationBloc>();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectDate(
                      datePicked: state.datePickedRegistered,
                      onDatePicked: (date) {
                        observationBloc.add(
                          RegisteredDateChanged(datePicked: date),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text('Danh sách các tiết đã đăng ký dự giờ:',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.brand600,
                        )),
                    const SizedBox(height: 8),
                    Expanded(
                      child: AppSkeleton(
                        isLoading: isLoading,
                        child: CustomRefresh(
                          onRefresh: () async {
                            observationBloc.add(RegisteredLessonFetch());
                          },
                          child: CustomScrollView(
                            slivers: [
                              if (isEmpty)
                                const SliverFillRemaining(
                                    child: Center(
                                  child: EmptyScreen(
                                      text: 'Bạn chưa đăng ký tiết dự giờ'),
                                )),
                              if (!isEmpty)
                                SliverList.builder(
                                  itemBuilder: (ctx, index) {
                                    final lesson = registeredLessonList[index];
                                    return CardRegisteredLesson(lesson: lesson);
                                  },
                                  itemCount: registeredLessonList.length,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
