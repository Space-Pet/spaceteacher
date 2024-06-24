import 'package:core/core.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_bloc.dart';

class CardObservation extends StatelessWidget {
  const CardObservation({
    super.key,
    required this.lesson,
  });
  final ObservationData lesson;

  @override
  Widget build(BuildContext context) {
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
                Text('Tiết ${lesson.lessonNum}',
                    style: AppTextStyles.normal16()),
                const SizedBox(height: 8),
                Text(
                  lesson.roomName,
                  style: AppTextStyles.normal14(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
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
                          lesson.subjectName,
                          style: AppTextStyles.semiBold16(
                              color: AppColors.blueForgorPassword),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'GV: ${lesson.teacherFullname}',
                          style:
                              AppTextStyles.normal14(color: AppColors.gray600),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            context.loaderOverlay.show();

                            context.read<ObservationBloc>().add(
                                  LessonRegisterPosted(data: lesson),
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.blue100,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tham gia dự giờ',
                                  style: AppTextStyles.semiBold12(
                                    color: AppColors.observationJoinText,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.add,
                                    color: AppColors.observationJoinText),
                              ],
                            ),
                          ),
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
