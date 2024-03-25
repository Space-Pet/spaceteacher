import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

import '../../../resources/assets.gen.dart';
import '../../profile/widget/profile_bottom_sheet.dart';

class AppBarAttendance extends StatelessWidget {
  const AppBarAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
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
                          style: AppTextStyles.normal16(
                            color: AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.academic,
                              color: AppColors.gray500,
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
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              enableDrag: false,
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
        ),
      ],
    );
  }
}
