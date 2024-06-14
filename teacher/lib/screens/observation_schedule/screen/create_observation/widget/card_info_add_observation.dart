import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';

class CardInfoAddObservation extends StatelessWidget {
  const CardInfoAddObservation({
    super.key,
    required this.teacherInfo,
    this.onTap,
    this.onRemove,
  });

  final TeacherItem teacherInfo;
  final void Function()? onTap;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.blueGray25,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.gray200),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherInfo.teacherFullname ?? '',
                    style: const TextStyle(
                        color: AppColors.blueForgorPassword,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Assets.icons.logoTeacher.svg(color: AppColors.gray400),
                      const SizedBox(width: 5),
                      Text(
                        'Giáo viên ${teacherInfo.teacherMainSubjectName}',
                        style: const TextStyle(color: AppColors.gray400),
                      ),
                      const SizedBox(width: 5),
                      //TODO: Render teacher class
                      // Container(
                      //   width: 3,
                      //   height: 3,
                      //   decoration: const BoxDecoration(
                      //     color: AppColors.gray400,
                      //     shape: BoxShape.circle,
                      //   ),
                      // ),
                      // const SizedBox(width: 5),
                      // Text(
                      //   teacherInfo.teacherClass,
                      //   style: const TextStyle(color: AppColors.gray400),
                      // ),
                    ],
                  ),
                ],
              ),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.brand500,
                    size: 20,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
