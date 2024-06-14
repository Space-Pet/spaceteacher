import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardObservation extends StatelessWidget {
  const CardObservation({
    super.key,
    required this.isFirstIndex,
    required this.isLastIndex,
    required this.nameObservation,
    required this.time,
    required this.descriptionSubjectLesson,
    required this.tietNum,
    required this.teacherName,
    required this.typeObservation,
  });
  final bool isFirstIndex;
  final bool isLastIndex;
  final String nameObservation;
  final String time;
  final String descriptionSubjectLesson;
  final String tietNum;
  final String teacherName;
  final int typeObservation;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.gray100,
          // borderRadius: isFirstIndex == true
          //     ? const BorderRadius.only(topRight: Radius.circular(20))
          //     : isLastIndex == true
          //         ?
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
          // : null,
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
                Text('Tiết $tietNum', style: AppTextStyles.normal14()),
                Text(time,
                    style: AppTextStyles.normal14(color: AppColors.gray400)),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    width: 4,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: const BoxDecoration(
                      color: AppColors.blueForgorPassword,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameObservation,
                            style: AppTextStyles.bold14(
                                color: AppColors.blueForgorPassword),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_vert_outlined,
                              color: AppColors.blueForgorPassword,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        descriptionSubjectLesson,
                        style: AppTextStyles.normal14(),
                      ),
                      Text(
                        'GV: $teacherName',
                        style: AppTextStyles.normal14(color: AppColors.gray400),
                      ),
                      const SizedBox(height: 10),
                      _onCreateStatusObservation(typeObservation)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _onCreateStatusObservation(int typeObservation) {
    switch (typeObservation) {
      case 1:
        return GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tham gia dự giờ',
                style: AppTextStyles.bold12(
                  color: AppColors.observationJoinText,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.add, color: AppColors.observationJoinText),
            ],
          ),
        );

      case 2:
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: AppColors.observationStatusPendingBg,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Chờ xác nhận',
                  style: AppTextStyles.bold12(
                    color: AppColors.observationStatusPendingText,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.restore,
                color: AppColors.observationStatusPendingText,
              ),
            ],
          ),
        );
      case 3:
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: AppColors.observationStatusSuccessdBg,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Đã xác nhận',
            style: AppTextStyles.bold12(
              color: AppColors.observationStatusSuccessText,
            ),
          ),
        );

      case 4:
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: AppColors.primaryRedColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Tiết của tôi',
            style: AppTextStyles.bold12(
              color: AppColors.white,
            ),
          ),
        );
      default:
        return GestureDetector(
          child: Row(
            children: [
              Text(
                'Tham gia dự giờ',
                style: AppTextStyles.bold12(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ],
          ),
        );
    }
  }
}
