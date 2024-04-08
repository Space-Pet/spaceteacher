import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:teacher/model/user_info.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';

import '../../profile/widget/profile_bottom_sheet.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({required this.userInfo, super.key});
  final UserInfo userInfo;
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
                      child: CachedNetworkImage(
                          imageUrl: kIsWeb
                              ? userInfo.children?.urlImageModel?.web ?? ""
                              : userInfo.children?.urlImageModel?.mobile ?? ''),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfo.children?.fullName ?? "",
                          style: AppTextStyles.normal16(
                            color: AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.academic,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                userInfo.children?.schoolName ?? "",
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
                                userInfo.children?.className ?? "",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.gray400,
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
