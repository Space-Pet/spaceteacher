import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/dialog/dialog_confirm.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_bloc.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/hourly_assessment_screen.dart';

class CardRegisteredLesson extends StatelessWidget {
  const CardRegisteredLesson({
    super.key,
    required this.lesson,
  });
  final RegisteredLesson lesson;

  @override
  Widget build(BuildContext context) {
    final observationBloc = BlocProvider.of<ObservationBloc>(context);

    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.gray100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tiết ${lesson.lessonRegisterTietNum}',
                    style: AppTextStyles.normal16()),
                const SizedBox(height: 8),
                Text(
                  lesson.lessonRegisterRoomName,
                  style: AppTextStyles.normal14(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.blueForgorPassword,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          lesson.lessonRegisterSubjectName,
                          style: AppTextStyles.semiBold16(
                              color: AppColors.blueForgorPassword),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'GV: ${lesson.lessonRegisterTeacherName}',
                          style:
                              AppTextStyles.normal14(color: AppColors.gray600),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context.push(HourAssessmentScreen(
                                  lesson: lesson,
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Đánh giá',
                                          style: AppTextStyles.semiBold14(
                                            color:
                                                AppColors.observationJoinText,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.edit_document,
                                          color: AppColors.observationJoinText,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DialogConfirm(
                                      title: 'Xác nhận xóa đăng ký dự giờ',
                                      content:
                                          'Thao tác này không thể hoàn tác. Bạn có chắc chắn muốn xóa đăng ký dự giờ này không?',
                                      yesText: "Xác nhận",
                                      noText: "Đóng",
                                      lesson: lesson,
                                      onYes: () {
                                        observationBloc.add(
                                          DeleteLessonRegistered(
                                            lessonRegisterId:
                                                lesson.lessonRegisterId,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Xóa đăng ký',
                                          style: AppTextStyles.semiBold14(
                                            color: AppColors.red500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.delete_forever_rounded,
                                          color: AppColors.red500,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
