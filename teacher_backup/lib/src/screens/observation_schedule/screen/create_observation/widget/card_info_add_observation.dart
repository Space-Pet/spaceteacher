import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/teacher_info_model.dart';
import 'package:teacher/resources/assets.gen.dart';

class CardInfoAddObservation extends StatelessWidget {
  const CardInfoAddObservation({
    super.key,
    required this.teacherInfo,
  });

  final TeacherInfo teacherInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gray200),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(1),
          onTap: () => {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: AppColors.black, width: 2),
          ),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.gray400,
            child: isNullOrEmpty(teacherInfo.urlImageModel?.mobile)
                ? Assets.images.avatar.image()
                : CachedNetworkImage(
                    imageUrl: teacherInfo.urlImageModel?.mobile ?? ""),
          ),
          title: Text(
            teacherInfo.fullName ?? "",
            style: const TextStyle(
                color: AppColors.blueForgorPassword,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Assets.icons.logoTeacher.svg(color: AppColors.gray400),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Giáo viên ${teacherInfo.mainSubject ?? ""}',
                style: const TextStyle(color: AppColors.gray400),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 3,
                height: 3,
                decoration: const BoxDecoration(
                  color: AppColors.gray400,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                teacherInfo.schoolName ?? '6.5',
                style: const TextStyle(color: AppColors.gray400),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Text(
              'X',
              style: AppTextStyles.bold16(
                  color: AppColors.observationStatusMyObsBG),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
