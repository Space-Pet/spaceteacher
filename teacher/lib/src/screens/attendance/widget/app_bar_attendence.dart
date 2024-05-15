import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/children_model.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';

import '../../profile/widget/profile_bottom_sheet.dart';

class AppBarAttendance extends StatelessWidget {
  const AppBarAttendance({required this.childrenModel, super.key});
  final ChildrenModel childrenModel;
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
                          imageUrl:
                              '${kIsWeb ? childrenModel.urlImageModel?.web : childrenModel.urlImageModel?.mobile}'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          childrenModel.fullName ?? "",
                          style: AppTextStyles.normal16(
                            color: AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Assets.icons.academic.svg(),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                childrenModel.schoolName ?? "",
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
                                childrenModel.className ?? "",
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
                          icon: const Icon(
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
