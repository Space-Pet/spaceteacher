import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../profile_teacher/widget/profile_bottom_sheet.dart';

class AppBarPhoneBook extends StatelessWidget {
  const AppBarPhoneBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/image_parent.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Ngọc Tuyết Lan',
                      style: AppTextStyles.normal16(),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.academic,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            'UKA Vũng Tàu',
                            style: AppTextStyles.normal12(
                              color: AppColors.gray500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.gray500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '6.1',
                            style: AppTextStyles.normal12(
                              color: AppColors.gray500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          enableDrag: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ProfileBottomSheet(
                              onIndexChanged: () {},
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
