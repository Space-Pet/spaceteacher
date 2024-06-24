import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_bloc.dart';
import 'package:teacher/screens/observation_schedule/widgets/card_info_add_observation.dart';
import 'package:teacher/screens/observation_schedule/widgets/card_observation.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      color: AppColors.white,
      child: BlocListener<ObservationBloc, ObservationState>(
        listener: (context, state) {
          switch (state.status) {
            case ObservationStatus.successRegister:
              context.loaderOverlay.hide();

              SnackBarUtils.showFloatingSnackBar(
                  context, 'Đăng ký dự giờ thành công!');
              break;

            case ObservationStatus.failureRegister:
              context.loaderOverlay.hide();
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Đăng ký thất bại, vui lòng thử lại sau!');
            default:
          }
        },
        child: BlocBuilder<ObservationBloc, ObservationState>(
          builder: (context, state) {
            return BlocBuilder<ObservationBloc, ObservationState>(
              builder: (context, state) {
                final listObservation = state.observationList;
                final isLoading = state.status == ObservationStatus.loading;
                final isEmpty = listObservation.isEmpty && !isLoading;

                final teacherList = state.teacherList;

                final observationBloc = context.read<ObservationBloc>();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectDate(
                      datePicked: state.datePicked,
                      firstDateLimit: DateTime.now(),
                      onDatePicked: (date) {
                        observationBloc.add(
                          DateChanged(datePicked: date),
                        );
                      },
                    ),
                    AppSkeleton(
                      isLoading:
                          state.status == ObservationStatus.loadingTeachers,
                      child: GestureDetector(
                        onTap: () {
                          showFlexibleBottomSheet(
                            context: context,
                            minHeight: 0,
                            initHeight: 0.7,
                            maxHeight: 1,
                            anchors: [0, 1],
                            isSafeArea: true,
                            bottomSheetBorderRadius: AppRadius.roundedTop16,
                            builder: (
                              BuildContext context,
                              ScrollController scrollController,
                              double bottomSheetOffset,
                            ) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: teacherList.length,
                                  itemBuilder: (context, index) {
                                    final teacherInfo = teacherList[index];
                                    final teacherSelected =
                                        state.teacherSelected;

                                    return GestureDetector(
                                      onTap: () {
                                        observationBloc.add(
                                          TeacherSelected(teacher: teacherInfo),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: CardInfoAddObservation(
                                        teacherInfo: teacherInfo,
                                        isSelected:
                                            teacherSelected?.teacherId ==
                                                teacherInfo.teacherId,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: AppColors.gray300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: AppColors.gray9000c,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          state.teacherSelected
                                                  ?.teacherFullname ??
                                              'Chọn giáo viên',
                                          style: AppTextStyles.normal16(
                                              color: AppColors.gray500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 24,
                                color: AppColors.gray900,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Danh sách các tiết bạn có thể dự giờ:',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.brand600,
                        )),
                    const SizedBox(height: 8),
                    Expanded(
                      child: AppSkeleton(
                        isLoading: isLoading,
                        child: isEmpty
                            ? Center(
                                child: EmptyScreen(
                                    text: state.teacherSelected == null
                                        ? 'Vui lòng chọn giáo viên'
                                        : 'Không có tiết dự giờ nào'),
                              )
                            // radius wrap list view 20px
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (ctx, index) {
                                    final lesson = listObservation[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // context.push(
                                        //   ObservationDetailScreen(data: lesson),
                                        // );
                                      },
                                      child: CardObservation(
                                        lesson: lesson,
                                      ),
                                    );
                                  },
                                  itemCount: listObservation.length,
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
