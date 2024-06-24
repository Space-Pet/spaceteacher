import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';

class CardInfoAddObservation extends StatelessWidget {
  const CardInfoAddObservation({
    super.key,
    required this.teacherInfo,
    this.onTap,
    this.onRemove,
    required this.isSelected,
  });

  final TeacherItem teacherInfo;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.brand600 : AppColors.blueGray25,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.gray200),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/default-user.png',
                  image: teacherInfo.teacherImg ?? '',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/default-user.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherInfo.teacherFullname ?? '',
                    style: TextStyle(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.blueForgorPassword,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Assets.icons.logoTeacher.svg(
                        color: isSelected ? AppColors.white : AppColors.gray600,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text('${teacherInfo.teacherMainSubjectName}',
                            style: AppTextStyles.normal14(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.gray600,
                            )),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
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
    );
  }
}
